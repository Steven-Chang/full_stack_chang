# frozen_string_literal: true

RSpec.shared_context 'admin is signed in', shared_context: :metadata do
  let!(:admin) { create(:user, email: 'admin@email.com', admin: true) }

  background do
		logged_as admin
  end
end
