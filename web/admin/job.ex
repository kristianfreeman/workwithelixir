defmodule Workwithelixir.ExAdmin.Job do
  use ExAdmin.Register

  register_resource Workwithelixir.Job do
    index do
      selectable_column
      column :id
      column :company
      column :title
      column :location
      actions
    end

    show job do
      attributes_table

      panel "Charge URL" do
        markup_contents do
          div raw("https://workwithelixir.com/jobs/#{job.id}/charge?token=#{Job.hash_for_charge(job)}")
        end
      end

      panel "Rendered job description" do
        markup_contents do
          div raw(Earmark.to_html(job.job_description))
        end
      end
    end

    form job do
      inputs do
        input job, :title
        input job, :company
        input job, :location
        input job, :job_description, type: :text
        input job, :apply_instructions, type: :text
        input job, :apply_url
        input job, :remote
        input job, :permanent
        input job, :salary
        input job, :company_url
        input job, :contact_email
        input job, :company_twitter
        input job, :paid
        input job, :status
        input job, :reviewed_by
        input job, :posted
      end
    end
  end
end
