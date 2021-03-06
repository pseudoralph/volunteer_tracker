class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id] ? attributes[:project_id] : nil
    @id = attributes[:id] ? attributes[:id] : nil
  end

  def self.all
    volunteers_from_db = DB.exec('SELECT * FROM volunteers;')
    volunteers = []

    volunteers_from_db.each do |volunteer|
      volunteers.push(Volunteer.new({
        name: volunteer['name'],
        project_id: volunteer['project_id'].to_i,
        id: volunteer['id'].to_i
        }))
    end
    volunteers
  end

  def self.find(volunteer_id)
    found_volunteer_from_db = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};").first
    volunteer = Volunteer.new({
      name: found_volunteer_from_db['name'],
      project_id: found_volunteer_from_db['project_id'].to_i,
      id: found_volunteer_from_db['id'].to_i
      })
  end

  def save
    if @project_id
      @id = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;").first['id'].to_i
    else
      @id = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
    end
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def update(new_attribs)
    @name = new_attribs[:name] ? new_attribs[:name] : @name
    @project_id = new_attribs[:project_id] ? new_attribs[:project_id].to_i : @project_id
    DB.exec("UPDATE volunteers SET project_id = #{@project_id}, name = '#{@name}' WHERE id = #{@id};")
  end

  def ==(other_volunteer)
    @name.==(other_volunteer.name) & @project_id.==(other_volunteer.project_id) & @id.==(other_volunteer.id)
  end
end
