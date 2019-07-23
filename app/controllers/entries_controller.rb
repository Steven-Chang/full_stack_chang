# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_entry, only: %i[update destroy]

  def by_date
    # now that we have a date
    # what i want is to check if we entries for that date and
    number_of_days_back = params['number_of_days_back'].to_i
    end_date = if params['date']
      params['date'].to_date
    elsif Entry.all.present?
      Entry.all.order('date DESC').first.date
    else
      Date.current
    end
    start_date = end_date - number_of_days_back.days
    while start_date <= end_date
      unless Entry.where(date: start_date).count.positive?
        Aim.all.each do |aim|
          aim.entries.create(date: start_date)
        end
      end
      start_date += 1.day
    end

    data = Entry.where('date >= ? and date <= ?', end_date - number_of_days_back.days, end_date)
                .joins(:aim)
                .select('entries.id, date, aim_id ,achieved, aims.description as aim_description')
                .order('date DESC')
                .group_by { |p| p['date'] }

    respond_with ({ data: data }).to_json
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.json { render json: @entry, status: :ok }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:date, :achieved, :aim_id)
  end
end
