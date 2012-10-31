module BanksHelper
  def account_kinds_select_for_bank(form)
    collect = Bank::ACCOUNT_KINDS.map do |k, v| 
      [t("view.banks.account_kinds.#{k}"), v]
    end

    form.input :kind, collection: collect, 
      selected: form.object.kind, prompt: false,
      label: false, input_html: { class: 'span12' } 
  end
  
  def currency_money_select_for_bank(form)
    collect = Bank::MONEY_KINDS.map do |k, v| 
      [t("view.banks.money_kinds.#{k}"), v]
    end

    form.input :currency, collection: collect, 
      selected: form.object.kind, prompt: false,
      label: false, input_html: { class: 'span12' } 
  end

  def translate_bank_account_currency(b_a)
    currency = Bank::MONEY_KINDS.invert[b_a]

    t("view.banks.money_kinds.#{currency}")
  end

  def translate_bank_account_kind(b_a)
    kind = Bank::ACCOUNT_KINDS.invert[b_a]

    t("view.banks.account_kinds.#{kind}")
  end
end
