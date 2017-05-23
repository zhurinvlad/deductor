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
  controller do
    # This code is evaluated within the controller class

    def new
      Questionnaire.create!(status: :ready)
      flash[:notice] = "Новая анкета успешно создана."
      redirect_to admin_questionnaires_path
    end
  end

  index do
    selectable_column
    column :uid
    column (:status) {|estimate| status_tag estimate.status, label: I18n.t("questionnaires.status.#{estimate.status}")}
    column :created_at
    column :updated_at
    actions
  end
  show do
    attributes_table do
      row :uid
      row (:status) {|estimate| status_tag estimate.status, label: I18n.t("questionnaires.status.#{estimate.status}")}
      row (:answer) {|estimate| textarea Nokogiri::XML(estimate.answer).to_xml, readonly: true, style: 'width: 100%; height: 420px;'}
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
