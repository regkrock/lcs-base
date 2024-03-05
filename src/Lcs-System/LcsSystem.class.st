Class {
	#name : #LcsSystem,
	#superclass : #LcsBaseSystem,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-System'
}

{ #category : #'initialize  ' }
LcsSystem >> domainClasses [
	^ LcsDomainObject withAllSubclasses
]

{ #category : #'ui \t' }
LcsSystem >> gtViewSystemOn: aView [
	<gtView>
	^ aView columnedList
		title: 'System Information' translated;
		priority: 5;
		items: [ self unitsOfWork ];
		column: 'Current'
			text: [ :eachItem :eachIndex | (eachItem == self currentUnitOfWork) displayString asRopedText foreground: Color gray ]
			width: 45;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Unit Of Work Name'
			text: [ :eachItem :eachIndex | eachItem unitOfWorkName asString asRopedText foreground: Color gray ]
			width: 140;
		column: 'Added'
			text: [ :eachItem :eachIndex | eachItem addedObjects size printString asRopedText foreground: Color gray ]
			width: 45;
		column: 'Changed'
			text: [ :eachItem :eachIndex | eachItem changedObjects size printString asRopedText foreground: Color gray ]
			width: 45;
column: 'Deleted'
			text: [ :eachItem :eachIndex | eachItem deletedObjects size printString asRopedText foreground: Color gray ]
			width: 45
]

{ #category : #'initialize  ' }
LcsSystem >> initialize [
	super initialize.
	self buildSlotDefinitions.
	self buildModules
]

{ #category : #'modules ' }
LcsSystem >> moduleClasses [
	^ OrderedCollection new
		add: LcsGeographyModule;
		add: LcsLegalEntitiesModule;
		yourself
]
