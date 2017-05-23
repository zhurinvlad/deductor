ActiveAdmin.register Questionnaire do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  member_action :analyze, method: :post do
    DeductorWorker.perform_async(resource.id)
    redirect_to admin_questionnaires_path, notice: "Анкета успешно поставлена в очередь на анализ!"
  end

  controller do
    def new
      Questionnaire.create!(status: :ready)
      flash[:notice] = "Новая анкета успешно создана."
      redirect_to admin_questionnaires_path
    end
  end

  filter :uid
  filter :is_analyze
  filter :status, as: :select, collection: Questionnaire.statuses.map{|k,v| [I18n.t("questionnaires.status.#{k}"), v]}
  filter :answer
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :uid
    column :is_analyze
    column (:status) {|q| status_tag q.status, label: I18n.t("questionnaires.status.#{q.status}")}
    column :created_at
    column :updated_at
    actions defaults: true do |q|
      link_to "Анализ", analyze_admin_questionnaire_path(q), method: :post, class: "member_link" if q.completed? && !q.is_analyze
    end
  end

  show do
    attributes_table do
      row :uid
      row :is_analyze
      row (:status) {|estimate| status_tag estimate.status, label: I18n.t("questionnaires.status.#{estimate.status}")}
      row (:answer) {|estimate| textarea Nokogiri::XML(estimate.answer).to_xml, readonly: true, style: 'width: 100%; height: 420px;'}
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
