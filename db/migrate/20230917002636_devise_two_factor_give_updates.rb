class DeviseTwoFactorGiveUpdates < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :encrypted_otp_secret_iv, :decimal
    remove_column :users, :encrypted_otp_secret_salt, :decimal
    rename_column :users, :encrypted_otp_secret, :otp_secret
  end
end
