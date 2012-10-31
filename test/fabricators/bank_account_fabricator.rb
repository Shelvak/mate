Fabricator(:bank_account) do
  number          { (0..20).map { rand(9) }.join }
  office_number   { 100 * rand }
  kind            { Bank::ACCOUNT_KINDS.values.sample }
  currency        { Bank::MONEY_KINDS.values.sample }
  amount          { 100.0 * rand }
  bank_id         { Fabricate(:bank).id }
end
