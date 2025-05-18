"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsSystem,
	#instVars : [
		'persons',
		'organization',
		'countries'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ super configurationSlotDefinition
]

{ #category : #'slot definition' }
LxxPrototypeSystem class >> countriesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'countries';
		addSlotType: LxxCountries;
		addCollectionMemberType: LxxCountry;
		yourself
]

{ #category : #configuration }
LxxPrototypeSystem class >> defaultModuleName [
	^ 'Prototype System'
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> moduleConfigurationClass [
	^ LxxPrototypeSystemConfiguration
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> organizationSlotDefinition [
	<slotDefinition>
	^ LcsDomainObjectSlot new
		slotName: 'organization';
		addSlotType: LxxOrganization;
		yourself
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPersons;
		addCollectionMemberType: LxxPerson;
		yourself
]

{ #category : #accessing }
LxxPrototypeSystem >> countries [
	^ self slotVarNamed: 'countries'
]

{ #category : #accessing }
LxxPrototypeSystem >> countries: anObject [
	self slotVarNamed: 'countries' put: anObject
]

{ #category : #testing }
LxxPrototypeSystem >> isInActiveStatus [
	self hasSlotModel ifFalse: [ ^ false ].
	^ self status isInActiveStatus
]

{ #category : #testing }
LxxPrototypeSystem >> isInSuspendedStatus [
	self hasSlotModel ifFalse: [ ^ true ].
	^ self status isInSuspendedStatus
]

{ #category : #testing }
LxxPrototypeSystem >> isPrototypeSystem [
	^ true
]

{ #category : #'as yet unclassified' }
LxxPrototypeSystem >> loadData [
	super loadData.
	LxxCountriesLoader new load.
	self applyChanges
]

{ #category : #accessing }
LxxPrototypeSystem >> organization [
	^ self slotVarNamed: 'organization'
]

{ #category : #accessing }
LxxPrototypeSystem >> organization: anObject [
	self slotVarNamed: 'organization' put: anObject
]

{ #category : #accessing }
LxxPrototypeSystem >> persons [
	^ self slotVarNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypeSystem >> persons: anObject [
	self slotVarNamed: 'presons' put: anObject
]

{ #category : #initialize }
LxxPrototypeSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	"self addClasses: self class package classes to: collection.
	collection
		add: #LxxCompositeStateMachine asClass;
		add: #LxxSubStateMachine asClass."
	^ collection
		add: LxxPrototype2Submodule;
		add: LxxOrganization;
		add: LxxPerson;
		add: LxxPersons;
		add: LxxCountry;
		add: LxxCountries;
		add: LxxCountrySubdivisions;
		add: LxxBaseCountrySubdivision;
		add: LxxPrototypeSystemConfiguration;
		addAll: LxxPrototypeSystem allSubmoduleClasses;
		yourself
]
