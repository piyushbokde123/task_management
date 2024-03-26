class TasksController < ApplicationController
	def index
    @tasks = Task.all
    @new_task = Task.new
    @statuses = ['All', 'To Do', 'In Progress', 'Done']
    @selected_status = params[:status] || 'All'
    if @selected_status != 'All'
      @tasks = @tasks.where(status: @selected_status)
    end
  end

  def create
    @task = Task.new(task_params)
    if can_create_task?(@task)
      if @task.save
        redirect_to tasks_path, notice: 'Task was successfully created.'
      else
        redirect_to tasks_path, alert: 'Error creating task.'
      end
    else
      redirect_to tasks_path, alert: 'Cannot create more "To Do" tasks.'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def can_create_task?(new_task)
    if new_task.status == 'To Do'
      todo_tasks_count = Task.where(status: 'To Do').count
      total_tasks_count = Task.count
      return todo_tasks_count < total_tasks_count * 0.5
    else
      return true
    end
  end
end
