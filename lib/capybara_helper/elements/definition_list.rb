module CapybaraHelper
  module Elements
    module DefinitionList
      def dl_hashes
        dt_cells = self.all("dt").map{ |cell| cell.text }
        dd_cells = self.all("dd").map{ |cell| cell.text }
        if dt_cells.count != dd_cells.count
          raise "number of dt do not match dt"
        end
        array = dt_cells.zip(dd_cells)
        Hash[*array.flatten]
      end
    end
  end
end