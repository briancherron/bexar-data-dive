package org.cinow.omh.menu;

public interface Item {
	String getId();
	void setId(String id);
	String getCategoryId();
	void setCategoryId(String id);
	String getName_en();
	void setName_en(String name_en);
	String getName_es();
	void setName_es(String name_es);
	String getDescription_en();
	void setDescription_en(String description_en);
	String getDescription_es();
	void setDescription_es(String description_es);
}
