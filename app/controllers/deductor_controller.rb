class DeductorController < ApplicationController
  def send_params
    client = Savon.client(wsdl: 'http://82.179.88.29/DIS3/Service.svc?wsdl',
                          log_level: :debug,
                          log: true,
                          pretty_print_xml: true,
                          env_namespace: :soap,
                          convert_request_keys_to: :none)
    logger.debug(client.operations)
    # => [:sum]
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
    render json: response.body
  end

end
