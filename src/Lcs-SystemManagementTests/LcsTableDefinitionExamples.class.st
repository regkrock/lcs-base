Class {
	#name : 'LcsTableDefinitionExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsTableDefinitionExamples >> countriesWithDefaultTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| countries |
	countries := LxxCountries new.
	self assert: countries tableDefinitions pendingAddsSize equals: 1.
	^ countries
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> countryTableDefinitoinWithOneColumnDefinitionAdded [
	<gtExample>
	<after: #clearUnitOfWork>
	| countryTableDefinition |
	countryTableDefinition := self tableDefinitionAddedToCountryCollection.
	countryTableDefinition addColumnDefinitionFor: LxxCountry isoCode3SlotDefinition.
	self assert: countryTableDefinition columnDefinitions hasElements.
	^ countryTableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> countryTableELements [
	<gtExample>
	<after: #clearUnitOfWork>
	| countryTableDefinition countries return |
	countries := self currentSystem countries.
	countryTableDefinition := self tableDefinitionAddedToCountryCollection.
	return := countryTableDefinition elements.
	self assert: return size equals: countries collection size.
	^ return
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> newTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition |
	self ensureCurrentSystemIsPrototypeSystem.
	tableDefinition := LcsTableDefinition new.
	self assert: (tableDefinition class == LcsTableDefinition).
	self assert: tableDefinition caption isEmpty.
	self assert: tableDefinition collectionSelector isSymbol.
	self assert: tableDefinition collectionSelector equals: #collection.
	self assert: tableDefinition columnDefinitions class name equals: #LcsTableColumnDefinitions.
	self assert: tableDefinition columnDefinitions hasNoElements.
	^ tableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> personsTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition persons  |
	persons := self currentSystem persons.
	tableDefinition := LcsTableDefinition newForCollectionSlot: LxxPrototypeSystem personsSlotDefinition.
	persons addTableDefinition: tableDefinition.
	self assert: persons tableDefinitions pendingAddsSize equals: 1.
	self assert: tableDefinition columnDefinitions pendingAddsSize equals: 12.
	self currentSystem applyChanges.
	self assert: persons tableDefinitions collectionSize equals: 1.
	self assert: tableDefinition columnDefinitions collectionSize equals: 12.
	persons tableDefinitions remove: tableDefinition.
	self assert: (persons tableDefinitions pendingDeletes includes: tableDefinition).
	self assert: persons tableDefinitions pendingDeletesSize equals: 1.
	self currentSystem applyChanges.
	self assert: persons tableDefinitions collectionSize equals: 0.
	^ tableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> skillsDefaultTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition |
	self ensureCurrentSystemIsPrototypeSystem.
	tableDefinition := LcsTableDefinition newForCollectionSlot: LxxPrototypeSystem skillsSlotDefinition.
	self assert: tableDefinition caption equals: 'Skills'.
	self assert: tableDefinition columnDefinitions pendingAddsSize equals: 2.
	self
		should: [ self currentSystem applyChanges ]
		raise: LcsUnitOfWorkAddObjectError
		description: 'LcsTableDefinition does not have a parent collection'.
	^ tableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> skillsWithDefaultTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| skills |
	self ensureCurrentSystemIsPrototypeSystem.
	skills := LxxSkills new.
	skills addTableDefinition: (LcsTableDefinition newDefaultOnClass: LxxSkill).
	self assert: skills tableDefinitions pendingAddsSize equals: 1.
	^ skills
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> tableDefinitionAddedToCountryCollection [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition |
	tableDefinition := self newTableDefinition.
	self currentSystem countries addTableDefinition: tableDefinition.
	self assert: self currentSystem countries tableDefinitions hasElements.
	self assert: (self currentSystem countries tableDefinitions includes: tableDefinition).
	self assert: tableDefinition parent equals: self currentSystem countries tableDefinitions.
	^ tableDefinition
]
