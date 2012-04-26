module JsonMethodArray

      def get_methods_array
            methods_array = [
                  :list_no, 
                  :list_price_currency,
                  :street_no_titleized,
                  :street_name_titleized,
                  :street_name_titleized,
                  :address_truncated,
                  :photo_url,
                  :no_bedrooms,
                  :no_half_baths,
                  :no_full_baths,
                  :square_feet_delimited,
                  :town_num,
                  :town
            ]

            return methods_array
      end
end