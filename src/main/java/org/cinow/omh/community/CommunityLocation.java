package org.cinow.omh.community;

/**
 * This object represents a location in the Community view.
 * 
 * @author brian
 */
public class CommunityLocation {
	
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
	 * The geojson.
	 */
	private String geojson;

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
	 * @return the geojson
	 */
	public String getGeojson() {
		return geojson;
	}

	/**
	 * @param geojson the geojson to set
	 */
	public void setGeojson(String geojson) {
		this.geojson = geojson;
	}
}
