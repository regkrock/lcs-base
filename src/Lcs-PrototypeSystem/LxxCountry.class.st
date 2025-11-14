Class {
	#name : #LxxCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'formalName',
		'isoCode3',
		'isoNumber',
		'commonName',
		'subdivisions',
		'subdivisionName',
		'subdivisionClass',
		'postalCodeClass'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition' }
LxxCountry class >> commonNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'commonName';
		addValidationCondition: [ :value :domainObject :oldValue | value size < 3 ] description: 'Must be 3 or more characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> formalNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'formalName';
		beAllowNil;
		addValidationCondition: [ :value :domainObject :oldValue | value size < 3 ] description: 'Must be 3 or more characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoCode3SlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoCode3';
		addValidationCondition: [ :value :domainObject :oldValue | value size ~= 3 ] description: 'Must be 3 characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoCode';
		addValidationCondition: [ :value :domainObject :oldValue | value size ~= 2 ] description: 'Must be 2 characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoNumberSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoNumber';
		addValidationCondition: [ :value :domainObject :oldValue | (value size = 3) not ] description: 'Must be 3 characters. Example: "001"';
		addValidationCondition: [ :value :domainObject :oldValue | value asInteger <= 0 or: [ value asInteger >= 1000 ] ] description: 'Must be in range 001 to 999';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotName: 'countries';
			collectionSlotModuleName: 'Prototype System';
			addSlotType: LxxCountries;
			yourself
]

{ #category : #'slot definition' }
LxxCountry class >> postalCodeClassSlotDefinition [
	<slotDefinition>
	| slotDefinition |
	slotDefinition := LcsPostalCodeClassSlot new.
	slotDefinition clearSlotTypes.
	slotDefinition superclassClass: LxxBasePostCode.
	slotDefinition initialValue: LxxGenericPostalCode.
	slotDefinition superclassClass subclassesDo: [ :eachClass | slotDefinition addSlotType: eachClass ].
	^ slotDefinition
]

{ #category : #'slot definition' }
LxxCountry class >> subdivisionClassSlotDefinition [
	<slotDefinition>
	| slotDefinition |
	slotDefinition := LcsCountrySubdivisionClassSlot new.
	slotDefinition clearSlotTypes.
	slotDefinition superclassClass:  LxxBaseCountrySubdivision.
	slotDefinition initialValue: LxxCountrySubdivision.
	slotDefinition superclassClass subclassesDo: [ :eachClass | slotDefinition addSlotType: eachClass ].
	^ slotDefinition
]

{ #category : #'slot definition' }
LxxCountry class >> subdivisionNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #subdivisionName;
		allowEmptyIntialValue;
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> subdivisionsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'subdivisions';
		addSlotType: LxxCountrySubdivisions;
		addCollectionMemberType: LxxBaseCountrySubdivision;
		yourself
]

{ #category : #accessing }
LxxCountry >> commonName [
	^ self slotVarNamed: 'commonName'
]

{ #category : #accessing }
LxxCountry >> commonName: anObject [
	self slotVarNamed: 'commonName' put: anObject
]

{ #category : #accessing }
LxxCountry >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : #accessing }
LxxCountry >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : #accessing }
LxxCountry >> isoCode3 [
	^ self slotVarNamed: 'isoCode3'
]

{ #category : #accessing }
LxxCountry >> isoCode3: anObject [
	self slotVarNamed: 'isoCode3' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoNumber [
	^ self slotVarNamed: 'isoNumber'
]

{ #category : #accessing }
LxxCountry >> isoNumber: anObject [
	self slotVarNamed: 'isoNumber' put: anObject
]

{ #category : #accessing }
LxxCountry >> postalCodeClass [
	^ self slotVarNamed: 'postalCodeClass'
]

{ #category : #accessing }
LxxCountry >> postalCodeClass: anObject [
	self slotVarNamed: 'postalCodeClass' put: anObject
]

{ #category : #accessing }
LxxCountry >> subdivisionClass [
	^ self slotVarNamed: 'subdivisionClass'
]

{ #category : #accessing }
LxxCountry >> subdivisionClass: anObject [
	self slotVarNamed: 'subdivisionClass' put: anObject
]

{ #category : #accessing }
LxxCountry >> subdivisionName [
	^ self slotVarNamed: 'subdivisionName'
]

{ #category : #accessing }
LxxCountry >> subdivisionName: anObject [
	self slotVarNamed: 'subdivisionName' put: anObject
]

{ #category : #accessing }
LxxCountry >> subdivisions [
	^ self slotVarNamed: 'subdivisions'
]

{ #category : #accessing }
LxxCountry >> subdivisions: anObject [
	self slotVarNamed: 'subdivisions' put: anObject
]
