require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
      
      # 削除リンクが、現在のユーザーによって作成されていないマイクロポストには
      # 表示されないことを確認するためのテストを作成してください。
      it "should render the delete link if user's post" do
        user.feed.each do |item|
          # TODO
        end
      end
      
      # サイドバーのマイクロポストカウントのテストを追加してください。
      # このとき、表示に単数形と複数形が正しく表示されているかどうかもテストしてください。
      it "should have correct count of microposts" do
        expect(page).to have_content(2)
        expect(page).to have_content("microposts")
      end

      it "should have correct count of micropost" do
        click_link('delete', match: :first)
        expect(page).to have_content(1)
        expect(page).to_not have_content("microposts")
        expect(page).to have_content("micropost")
      end
      
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
        
        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
          
    end
  end
  
  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end

    it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "sample_app"
    expect(page).to have_title(full_title(''))
    
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))

  end
end
