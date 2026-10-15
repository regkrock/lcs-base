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
	self ensureCurrentSystemIsPrototypeSystem.
	countries := LxxCountries new.
	self assert: self currentSystem tableDefinitions pendingAddsSize equals: 0.
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
	self assert: tableDefinition parent isNil.
	self assert: tableDefinition domainCollectionSelector isEmpty.
	^ tableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> personsTableDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition persons  |
	self ensureCurrentSystemIsPrototypeSystem.
	persons := self currentSystem persons.
	tableDefinition := LcsTableDefinition newForCollectionSlot: LxxPrototypeSystem personsSlotDefinition.
	self currentSystem addTableDefinition: tableDefinition.
	self assert: self currentSystem tableDefinitions pendingAddsSize equals: 1.
	self assert: tableDefinition columnDefinitions pendingAddsSize equals: 12.
	self assert: self currentSystem tableDefinitions pendingAdds includes: tableDefinition .	self currentSystem applyChanges.
	self assert: self currentSystem tableDefinitions includes: tableDefinition .
	self assert: tableDefinition columnDefinitions collectionSize equals: 12.
	self currentSystem tableDefinitions remove: tableDefinition.
	self assert: self currentSystem tableDefinitions pendingDeletes includes: tableDefinition.
	self assert: self currentSystem tableDefinitions pendingDeletesSize equals: 1.
	self currentSystem applyChanges.
	self assert: tableDefinition tableDefinitionName equals: 'persons'.
	self assert: tableDefinition tableDefinitionName equals: #'persons'.
	"self assert: self currentSystem tableDefinitions collectionSize equals: 0."
	^ tableDefinition
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> personsTableDefinitionWithNondefaultName [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition  |
	tableDefinition := self personsTableDefinition.
	self assert: tableDefinition tableDefinitionName equals: 'persons'.
	self assert: tableDefinition tableDefinitionName equals: #'persons'.
	tableDefinition domainCollectionSelector: #'personsUniqueName'.
	self assert: tableDefinition domainCollectionSelector equals: #'personsUniqueName'.
	self assert: tableDefinition tableDefinitionName equals: #'persons'.

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
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem addTableDefinition: (LcsTableDefinition newDefaultOnClass: LxxSkill).
	self assert: self currentSystem tableDefinitions pendingAddsSize equals: 1.
	^ self currentSystem tableDefinitions
]

{ #category : 'examples' }
LcsTableDefinitionExamples >> tableDefinitionAddedToCountryCollection [
	<gtExample>
	<after: #clearUnitOfWork>
	| tableDefinition |
	tableDefinition := self newTableDefinition.
	tableDefinition domainCollectionSelector: #countries.
	self currentSystem addTableDefinition: tableDefinition.
	self assert: self currentSystem tableDefinitions hasElements.
	self assert: (self currentSystem tableDefinitions includes: tableDefinition).
	self assert: tableDefinition parent equals: self currentSystem tableDefinitions.
	^ tableDefinition
]
