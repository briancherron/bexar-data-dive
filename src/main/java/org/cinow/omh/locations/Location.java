package org.cinow.omh.locations;

/**
 * This object represents a location.
 * 
 * @author brian
 */
public class Location {
	
	/**
	 * The id.
	 */
	private String id;

	/**
	 * The type id.
	 */
	private String typeId;

	/**
	 * The name (English).
	 */
	private String name_en;

	/**
	 * The name (Spanish).
	 */
	private String name_es;

	/**
	 * The description (English).
	 */
	private String description_en;

	/**
	 * The description (Spanish).
	 */
	private String description_es;
	
	/**
	 * @return the categoryId
	 */
	public String getCategoryId() {
		return typeId;
	}

	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(String id) {
		this.typeId = id;
	}
	
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * @return the typeId
	 */
	public String getTypeId() {
		return typeId;
	}
	
	/**
	 * @param typeId the typeId to set
	 */
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
	/**
	 * @return the name_en
	 */
	public String getName_en() {
		return name_en;
	}
	
	/**
	 * @param name_en the name_en to set
	 */
	public void setName_en(String name_en) {
		this.name_en = name_en;
	}
	
	/**
	 * @return the name_es
	 */
	public String getName_es() {
		return name_es;
	}
	
	/**
	 * @param name_es the name_es to set
	 */
	public void setName_es(String name_es) {
		this.name_es = name_es;
	}

	/**
	 * @return the description_en
	 */
	public String getDescription_en() {
		return description_en;
	}

	/**
	 * @param description_en the description_en to set
	 */
	public void setDescription_en(String description_en) {
		this.description_en = description_en;
	}

	/**
	 * @return the description_es
	 */
	public String getDescription_es() {
		return description_es;
	}

	/**
	 * @param description_es the description_es to set
	 */
	public void setDescription_es(String description_es) {
		this.description_es = description_es;
	}
}
