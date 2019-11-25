require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  describe "GET #new" do
    context 'without signed in user' do
      it 'redirects the user to session new' do
        get(:new)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with signed in user' do
      before do
        session[:user_id] = current_user.id
      end

      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders a new template" do
        get(:new)
        expect(response).to(render_template(:new))
      end

      it "sets an instance variable with a new job post" do
        get(:new)
        expect(assigns(:idea)).to(be_a_new(Idea))
      end
    end
  end

  describe "GET #create" do
    def valid_request
      post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
    end

    context 'without signed in user' do
      it 'redirects to the new session page' do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with signed in user' do
      before do
        session[:user_id] = current_user.id
      end

    # context is functionally the same as describe, but we
    # use it to organize groups of branching code paths.
      it 'saves a new idea to the db' do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to the show page of that idea' do
        valid_request
        idea = Idea.last
        expect(response).to(redirect_to(idea_path(idea.id)))
      end
      it "associates the current user to the created idea" do
        valid_request

        idea = Idea.last
        # byebug
        expect(idea.user).to eq(current_user)
      end
    end
  end
end
