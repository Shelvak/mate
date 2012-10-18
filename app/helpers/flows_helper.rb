module FlowsHelper
  def in_or_out_select_for_flow(form)
    in_or_out_collection = [
      [t('view.flows.in'), true], [t('view.flows.out'), false]
    ]

    form.input :in, collection: in_or_out_collection,
      selected: form.object.in, prompt: false
  end

  def cash_detail_select_for_flows(form)
    detail_kinds = Cash::KINDS.map { |k, v| [t("view.flows.kinds.#{k}"), v] }

    form.input :detail, collection: detail_kinds, label: false,
      selected: form.object.detail, prompt: false,
      input_html: { class: 'span12' }
  end
end
