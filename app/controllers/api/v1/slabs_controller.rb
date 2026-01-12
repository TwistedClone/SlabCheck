module Api
  module V1
    class SlabsController < ApplicationController
      def index
        slabs = Slab.includes(:grading_company).order(created_at: :desc)

        render json: slabs.map { |s| serialize_slab(s) }
      end

      def show
        slab = Slab.find(params[:id])
        render json: serialize_slab(slab)
      end

      private

      def serialize_slab(slab)
        {
          id: slab.id,
          cert_number: slab.cert_number,
          grading_company: slab.grading_company.code,
          card_name: slab.card_name,
          grade: slab.grade,
          verified: slab.verified,

          population: {
            total: slab.population_total,
            higher: slab.population_higher,
            percentage: slab.population_percentage
          }
        }
      end
    end
  end
end
