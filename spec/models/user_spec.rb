require 'rails_helper'
# require 'devise'

# require 'user'


RSpec.describe "User authentication", type: :feature do
  let(:user) { User.create!(name: 'User1', email: 'user2@example.com', password: 'password') }

  scenario "User signs in with valid credentials" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'You are now logged in'
  end

  scenario "User signs in with invalid credentials" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Log in'
    save_and_open_page
    expect(page).to have_content 'Invalid Email or password'
  end
end


RSpec.describe "User edit account", type: :feature do
  let(:user) { User.create!(name: 'User1', email: 'user2@example.com', password: 'password') }

  scenario "User save edit with valid credentials" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Edit'
    fill_in 'Password', with: 'newpass123'
    fill_in 'Password confirmation', with: 'newpass123'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content 'You are now logged in'
  end

  scenario "User cancel your account" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Edit'
    click_button 'Cancel my account'
    expect(page).to have_content 'Your account has been successfully cancelled'
  end
end

=begin

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'User1', email: 'user@gmail.com',  password: 'password') }
  #  permite definir uma variável local em uma especificação que pode ser acessada em todo o escopo da especificação. O valor da variável é definido em um bloco que é avaliado apenas quando a variável é chamada pela primeira vez.

  #Usar o let em vez de definir uma variável diretamente tem algumas vantagens. Em particular, o let garante que o valor da variável é definido apenas quando necessário e que é reutilizado em cada chamada subsequente, em vez de ser definido novamente a cada chamada. Isso torna as especificações mais rápidas, uma vez que evita a criação desnecessária de objetos ou recursos.
  
  describe 'authentication' do
    it 'authenticates with correct name, email and password' do
      expect(user.authenticate(user.email,'password')).to eq(user) 
      # O método authenticate é fornecido pelo Rails para verificar se a senha fornecida pelo usuário corresponde à senha armazenada no banco de dados.
    end

    it 'does not authenticate with incorrect password' do
      expect(user.authenticate(user.email,'passor')).to be_falsey
    end

    it 'does not authenticate with incorrect email' do
      expect(user.authenticate('wrong_email@gmail.com', 'password')).to be_falsey
    end

    it 'does not authenticate with blank email' do
      expect(user.authenticate('', 'password')).to be_falsey
    end

    it 'does not authenticate with blank password' do
      expect(user.authenticate(user.email, '')).to be_falsey
    end

  end

  describe 'attributes' do
      it 'has a name' do
        expect(user.name).to eq('User1')
      end
  
      it 'has an email' do
        expect(user.email).to eq('user@gmail.com')
      end
    end
    
end

=end



=begin
RSpec.describe User, type: :controller do
let(:user) { User.create(email: 'test@example.com', password: 'password') }

  describe 'POST #create' do
    it 'authenticates a user with valid email and password' do
      post :create, params: { session: { email: user.email, password: 'password' } }
      expect(response).to redirect_to(root_path)
      expect(controller.current_user).to eq(user)
    end

    it 'does not authenticate a user with invalid email or password' do
      post :create, params: { session: { email: user.email, password: 'wrong_password' } }
      expect(response).to render_template(:new)
      expect(controller.current_user).to be_nil
    end
  end

end

RSpec.describe 'Post' do           #
  context 'before publication' do  # (almost) plain English
    it 'cannot have comments' do   #
      expect { Post.create.comments.create! }.to raise_error(ActiveRecord::RecordInvalid)  # test code
    end
  end
end

describe 'Authenticated Users Activities' do
  before do
    @user = User.create(name: 'User1', email: 'user1@gmail.com',  password: 'password')
    sign_in @user
  end
  it 'should successfully access post timeline' do
    get posts_path
    assert_response :success
  end
  it 'should be able to create a post' do
    @post = @user.posts.new(content: 'test post').save
    expect(@post).to eq(true)
  end
end
=end