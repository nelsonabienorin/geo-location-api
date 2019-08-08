class JsonParserService
  def initialize (file)
    begin
      read_file = File.read(file)
      @json = JSON.parse(read_file)
    rescue StandardError => message
      render json: {message: "Error reading file: #{message}"}, status: 500
    end
  end

  def parser
    @json
  end
end