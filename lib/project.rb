class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id] ? attributes[:id] : nil

  end

  def self.all
    all_projects_from_db = DB.exec("SELECT * FROM projects")
    all_projects = []

    all_projects_from_db.each do |project|
      all_projects.push(Project.new({
        title: project["title"],
        id: project["id"].to_i
        }))
    end
    all_projects
  end

  def ==(other_proj)
    @title.==(other_proj.title) & @id.==(other_proj.id)

  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first["id"].to_i
  end

end
