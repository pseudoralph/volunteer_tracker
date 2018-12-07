class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id] ? attributes[:id] : nil

  end

  def self.all
    projects_from_db = DB.exec("SELECT * FROM projects")
    projects = []

    projects_from_db.each do |project|
      projects.push(Project.new({
        title: project['title'],
        id: project['id'].to_i
        }))
    end
    projects
  end

  def self.find(project_id)
    found_proj_from_db = DB.exec("SELECT * FROM projects WHERE id = #{project_id};").first

    Project.new({
      title: found_proj_from_db['title'],
      id: found_proj_from_db['id'].to_i
      })
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first["id"].to_i
  end

  def update(new_attribs)
    @title = new_attribs[:title] ? new_attribs[:title] : @title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  def volunteers
    volunteers_on_project_from_db = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    volunteers_on_project = []

    volunteers_on_project_from_db.each do |volunteer|
      volunteers_on_project.push(Volunteer.new({
        name: volunteer['name'],
        project_id: volunteer['project_id'].to_i,
        id: volunteer['id'].to_i
        }))
    end
    volunteers_on_project
  end

  def ==(other_proj)
    @title.==(other_proj.title) & @id.==(other_proj.id)
  end

end
