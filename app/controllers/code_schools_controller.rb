class CodeSchoolsController < ApplicationController
  include Carmen

  def index
    code_schools = CodeSchools.new
    @va_accepted_code_schools = code_schools.va_accepted
    @code_schools_by_state = code_schools.by_state
    @country = Country.named('United States')
  end

  def map
    schools = CodeSchools.new
    respond_to do |format|
      format.html
      format.json { render json: schools.as_geojson }
    end
  end
end
