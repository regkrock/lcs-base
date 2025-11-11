"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsSystem,
	#instVars : [
		'persons',
		'organization',
		'countries',
		'skills'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
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

{ #category : #configuration }
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

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> skillsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'skills';
		addSlotType: LxxSkills;
		addCollectionMemberType: LxxSkill;
		yourself
]

{ #category : #initialize }
LxxPrototypeSystem >> addTempClassesTo: collection [
	"This is present so starting and stopping the system with temp classes works"

	| tempClasses |
	tempClasses := [ 'Lcs-Temp' asPackage classes ]
			on: NotFound
			do: [ :s | s return: #() ].
	(tempClasses
		reject: [ :each | each isMeta or: [ (each inheritsFrom: LcsBaseDomainObject) not ] ])
		do: [ :each | collection add: each ]
]

{ #category : #accessing }
LxxPrototypeSystem >> countries [
	^ self slotVarNamed: 'countries'
]

{ #category : #accessing }
LxxPrototypeSystem >> countries: anObject [
	self slotVarNamed: 'countries' put: anObject
]

{ #category : #convenience }
LxxPrototypeSystem >> dummySlotDefinition [
]

{ #category : #views }
LxxPrototypeSystem >> gtConfigurationFor: aView [
	<gtView>
	^ aView forward
		title: 'Configuration';
		object: [ self configuration ];
		view: #gtMagritteFor:
]

{ #category : #testing }
LxxPrototypeSystem >> isPrototypeSystem [
	^ true
]

{ #category : #data }
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
	self slotVarNamed: 'persons' put: anObject
]

{ #category : #accessing }
LxxPrototypeSystem >> skills [
	^ self slotVarNamed: 'skills'
]

{ #category : #accessing }
LxxPrototypeSystem >> skills: anObject [
	self slotVarNamed: 'skills' put: anObject
]

{ #category : #initialize }
LxxPrototypeSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.	"self addClasses: self class package classes to: collection.
	collection
		add: #LxxCompositeStateMachine asClass;
		add: #LxxSubStateMachine asClass."
	collection
		add: LxxPrototype2Submodule;
		add: LxxOrganization;
		add: LxxPerson;
		add: LxxPersons;
		add: LxxCountry;
		add: LxxCountries;
		add: LxxCountrySubdivisions;
		add: LxxBaseCountrySubdivision;
		add: LxxPrototypeSystemConfiguration;
		addAll: LxxPrototypeSystem allSubmoduleClasses.

	self addTempClassesTo: collection.

	^ collection
]
