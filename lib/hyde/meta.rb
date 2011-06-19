# Class: Hyde::Meta
# Metadata.
#
# This is usually accessed via {Hyde::Page.meta}.

class Hyde
class Meta < OpenStruct
  def merge!(hash)
    @table.merge(hash)
  end

  # For Ruby 1.8.6 compatibility ([:type] instead of .type)
  def [](id)
    @table[id.to_sym]
  end
end
end
