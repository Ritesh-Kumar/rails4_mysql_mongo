# encoding : utf-8
class PoliciesController < BeautifulController
  before_filter :authenticate_user!
  before_filter :load_policy, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:policy] ||= (Policy.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:policy)
    do_sort_and_paginate(:policy)
    
    @q = Policy.search(
      params[:q]
    )

    @policy_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @policy_scope_for_scope = @policy_scope.dup
    
    unless params[:scope].blank?
      @policy_scope = @policy_scope.send(params[:scope])
    end
    
    @policies = @policy_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @policy_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Policy.attribute_names
          @policy_scope.to_a.each{ |o|
            csv << Policy.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @policy_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Policy,@policy_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @policy }
    end
  end

  def new
    @policy = Policy.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @policy }
    end
  end

  def edit
    
  end

  def create
    @policy = Policy.create(params_for_model)

    respond_to do |format|
      if @policy.save
        format.html {
          if params[:mass_inserting] then
            redirect_to policies_path(:mass_inserting => true)
          else
            redirect_to policy_path(@policy), :flash => { :notice => t(:create_success, :model => "policy") }
          end
        }
        format.json { render :json => @policy, :status => :created, :location => @policy }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to policies_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @policy.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @policy.update_attributes(params_for_model)
        format.html { redirect_to policy_path(@policy), :flash => { :notice => t(:update_success, :model => "policy") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @policy.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.destroy

    respond_to do |format|
      format.html { redirect_to policies_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @policies = []    
    
    Policy.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:policy)

        @policies = Policy.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @policies = Policy.find(params[:ids].to_a)
      end

      @policies.each{ |policy|
        if not Policy.columns_hash[attr_or_method].nil? and
               Policy.columns_hash[attr_or_method].type == :boolean then
         policy.update_attribute(attr_or_method, boolean(value))
         policy.save
        else
          case attr_or_method
          # Set here your own batch processing
          # policy.save
          when "destroy" then
            policy.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Policy
    foreignkey = :policy_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_policy
    @policy = Policy.find(params[:id])
  end

  def params_for_model
    params.require(:policy).permit(Policy.permitted_attributes)
  end
end

