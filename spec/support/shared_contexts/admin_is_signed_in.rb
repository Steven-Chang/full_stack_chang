# frozen_string_literal: true

RSpec.shared_context 'admin is signed in', shared_context: :metadata do
  let!(:admin) { create(:user, email: 'prime_pork@hotmail.com', admin: true) }

  background do
		logged_as admin
  end
end
