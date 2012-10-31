module ClientsHelper
  def iva_kinds_select_for_client(form)
    collect = Client::IVA_KINDS.map do |n, v| 
      [t("view.iva_kinds.#{n}"), v]
    end

    form.input :iva_responsive, collection: collect,
      select: form.object.iva_responsive, prompt: false,
      required: false
  end
end
