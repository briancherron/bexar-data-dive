package org.cinow.omh.explore;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

import org.cinow.omh.filters.Filter;
import org.cinow.omh.filters.FilterOption;
import org.cinow.omh.filters.FilterRepository;
import org.cinow.omh.filters.Filters;
import org.cinow.omh.indicators.IndicatorRepository;
import org.cinow.omh.sources.SourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service class for the Explore Data view.
 */
@Service
public class ExploreService {

	/**
	 * The explore repository.
	 */
	@Autowired
	private ExploreRepository exploreRepository;

	/**
	 * The indicator repository.
	 */
	@Autowired
	private IndicatorRepository indicatorRepository;

	/**
	 * The source repository.
	 */
	@Autowired
	private SourceRepository sourceRepository;

	/**
	 * The filter repository.
	 */
	@Autowired
	private FilterRepository filterRepository;
	
	/**
	 * Get the data for the Explore Data view.
	 * 
	 * @param dataRequest the dataDequest
	 * @return the data
	 */
	public ExploreData getExploreData(ExploreDataRequest dataRequest) {
		ExploreData exploreData = new ExploreData();
		exploreData.setIndicator(this.indicatorRepository.getIndicator(dataRequest.getIndicator()));
		exploreData.setSource(this.sourceRepository.getSourceByIndicator(dataRequest.getIndicator()));
		exploreData.setFilters(this.getIndicatorFilters(dataRequest));
		exploreData.setLocationData(this.exploreRepository.getExploreData(dataRequest, true));

		if (dataRequest.getComparisons() != null) {
			exploreData.setCompareData(new ArrayList<>());
			if (dataRequest.getComparisons().getType().getName_en().equals("Location")) {
				for (FilterOption option : dataRequest.getComparisons().getOptions()) {
					dataRequest.getFilters().setLocation(option.getId());
					dataRequest.getFilters().setLocationType(option.getTypeId());
					exploreData.getCompareData().addAll(this.exploreRepository.getExploreData(dataRequest, false));
				}		
			} else {
				for (FilterOption option : dataRequest.getComparisons().getOptions()) {
					dataRequest.getFilters().getIndicatorFilters().put(dataRequest.getComparisons().getType().getId(), option);
					exploreData.getCompareData().addAll(this.exploreRepository.getExploreData(dataRequest, false));
				}
			}
		}

		return exploreData;
	}

	/**
	 * Get the filters for a data request.
	 * 
	 * @param dataRequest the dataDequest
	 * @return the filters
	 */
	private Filters getIndicatorFilters(ExploreDataRequest dataRequest) {
		Filters filters = new Filters();
		filters.setLocationTypeFilter(this.filterRepository.getLocationTypeFilter(dataRequest.getIndicator()));
		filters.getLocationTypeFilter().setOptions(filters.getLocationTypeFilter().getOptions()
			.stream()
			.filter(o -> o.getId().equals(dataRequest.getFilters().getLocationType()))
			.collect(Collectors.toList()));
		filters.setLocationFilter(this.filterRepository.getLocationFilter());
		filters.getLocationFilter().setOptions(filters.getLocationFilter().getOptions()
			.stream()
			.filter(o -> o.getId().equals(dataRequest.getFilters().getLocation()) && o.getTypeId().equals(dataRequest.getFilters().getLocationType()))
			.collect(Collectors.toList()));
		filters.setYearFilter(this.filterRepository.getYearFilter(dataRequest.getIndicator()));
		filters.getYearFilter().setOptions(filters.getYearFilter().getOptions()
			.stream()
			.filter(o -> o.getId().equals(dataRequest.getFilters().getYear()))
			.collect(Collectors.toList()));
		filters.setIndicatorFilters(this.filterRepository.getIndicatorFilters(dataRequest.getIndicator()));
		for (Filter filter : filters.getIndicatorFilters()) {
			filter.setOptions(Arrays.asList(dataRequest.getFilters().getIndicatorFilters().get(filter.getType().getId())));
		}

		return filters;
	}
}
