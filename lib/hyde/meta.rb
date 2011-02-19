class Hyde
class Meta < OpenStruct
  def merge!(hash)
    @table.merge(hash)
  end
end
end
