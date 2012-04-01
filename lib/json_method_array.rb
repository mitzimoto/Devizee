module JsonMethodArray

      def get_methods_array
            methods_array = [
                  :list_no, 
                  :list_agent, 
                  :list_office,
                  :status,
                  :list_price,
                  :town_num,
                  :zip_code,
                  :photo_count,
                  :photo_date,
                  :photo_mask,
                  :lender_owned,
                  :virtual_tours,
                  :open_houses,
                  :street_no,
                  :street_name,
                  :taxes,
                  :tax_year
            ]

            return methods_array
      end
end
