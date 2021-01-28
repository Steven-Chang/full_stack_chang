# frozen_string_literal: true

# example of deposity history

cl = Credential.last.trade_pairs.first.client
cl.deposit_history(timestamp: Time.current.to_i * 1000)
