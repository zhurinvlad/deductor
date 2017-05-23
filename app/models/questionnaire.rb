class Questionnaire < ApplicationRecord
  # gray, yellow, green, red
  enum status: [:ready, :warn, :completed, :error]
  before_create :randomize_id

  def send_to_deductor
    logger.debug(self.answer)
    client = Savon.client(wsdl: 'http://82.179.88.29/DIS3/Service.svc?wsdl',
                          log_level: :debug,
                          log: true,
                          pretty_print_xml: true,
                          env_namespace: :soap,
                          convert_request_keys_to: :none)
    logger.debug(client.operations)
    # Список операций => [:sum]
    response = client.call(:sum,
                           message: {
                               variables: {
                                   :@xmlns => ""
                               },
                               data:  {
                                   :@xmlns => "",
                                   :content! => {
                                       input:  {
                                           :@xmlns => "http://www.basegroup.ru/warehouses/XsdDbConnection",
                                           :content! =>  {
                                               Item1: {
                                                   :@xmlns => "DIS_Sum",
                                                   :content! => 15
                                               },
                                               Item2:  {
                                                   :@xmlns => "DIS_Sum",
                                                   :content! => 15
                                               },
                                           }
                                       }
                                   }
                               }
                           }
    )
    logger.debug(response.body.to_json)
    return response.body
  end

  private
  def randomize_id
    begin
      self.uid = SecureRandom.hex(15)
    end while Questionnaire.where(id: self.uid).exists?
  end

end
