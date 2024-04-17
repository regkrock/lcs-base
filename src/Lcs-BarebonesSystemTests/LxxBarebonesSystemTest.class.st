Class {
	#name : #LxxBarebonesSystemTest,
	#superclass : #LcsDomainTest,
	#instVars : [
		'system1',
		'system2'
	],
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #accessing }
LxxBarebonesSystemTest >> system1 [
	^ system1
]

{ #category : #accessing }
LxxBarebonesSystemTest >> system1: anObject [
	^ system1 := anObject
]

{ #category : #accessing }
LxxBarebonesSystemTest >> system2 [
	^ system2
]

{ #category : #accessing }
LxxBarebonesSystemTest >> system2: anObject [
	^ system2 := anObject
]

{ #category : #running }
LxxBarebonesSystemTest >> tearDown [
	self system1 ifNotNil: [ 
		self system1 removeSystem.
		self system1: nil ].
	self system2 ifNotNil: [ 
		self system2 removeSystem.
		self system2: nil ].
	super tearDown

]

{ #category : #tests }
LxxBarebonesSystemTest >> testBarebonesCreation [
	| allDomainClasses |

	self system1: LxxBarebonesSystem new.
	self assert: self system1 currentUnitOfWork hasNoChanges.
	self assert: (self system1 slotDefinitionNamed: 'persons') notNil.
	self assert: self system1 persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotModel hasElements.
	self assert: self system1 configuration class name equals: #LxxBarebonesSystemConfiguration.
	self assert: self system1 hasSlotModels .
	self assert: self system1 systemSlotModel slotModels size equals: LcsApplicationEnvironment currentSystem initialSystemDomainClasses size.
	allDomainClasses := LcsDomainObject withAllSubclasses asOrderedCollection.
	self system1 systemSlotModel slotModels keysDo: [ :each | allDomainClasses remove: each ifAbsent: [ ] ].
	self assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotModel isNil ])
]

{ #category : #tests }
LxxBarebonesSystemTest >> testChangedSlotInDomainObject [
	| domainObject |
	self system1: LxxBarebonesSystem new.
	domainObject := LxxBarebonesPerson new dateOfBirth: Date today.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: domainObject dateOfBirth equals: Date today.
	self assert: ((self currentSystem persons) includes: domainObject).
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

	domainObject dateOfBirth: Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects size equals: 1.
	self assert: (self currentSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: self currentSystem currentUnitOfWork changedObjects any domainObject identicalTo: domainObject.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth = Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreatingNewDomainObject [
	| domainObject |
	self system1: LxxBarebonesSystem new.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := LcsDomainObject new.
	self assert: self currentSystem currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: self currentSystem currentUnitOfWork addedObjects any domainObject identicalTo: domainObject
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationOfNewSystem [
	self system1: LxxBarebonesSystem new.
	self assert: self currentSystem class identicalTo: LxxBarebonesSystem.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxBarebonesPersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotModel hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationWithBareBonesSystem [
	| domainObject |
	self system1: LxxBarebonesSystem new.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem identicalTo:self system1.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject identicalTo: domainObject.
	self assert: domainObject slotModel className equals: 'LcsSlotModel' .
]

{ #category : #accessing }
LxxBarebonesSystemTest >> testInstallingFirstNameSlotInPerson [
	self deny: (LxxBarebonesPerson instVarNames includes: 'firstName').
	self deny: (LxxBarebonesPerson respondsTo: #firstName).
	self deny: (LxxBarebonesPerson respondsTo: #firstName:).
	self deny: (LxxBarebonesPerson class respondsTo: #firstNameSlotDefinition).
]

{ #category : #tests }
LxxBarebonesSystemTest >> testNewUnitOfWorkInSystem [
	self system1: LxxBarebonesSystem new.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : #tests }
LxxBarebonesSystemTest >> testSystemCreation [
	| numberOfSystems |
	numberOfSystems := self systemManager numberOfSystems.
	self system1: LxxBarebonesSystem new. 

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system1.
	self assert: LcsApplicationEnvironment currentUnitOfWork identicalTo: self system1 relatedUnitOfWork.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: self system1 hasValidConfiguration.

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxBarebonesPersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxBarebonesPerson slotModel hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration.

]

{ #category : #tests }
LxxBarebonesSystemTest >> testSystemRemoval [
	| numberOfSystems numberOfUnitsOfWork |
	
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.

	self system1: LxxBarebonesSystem new.
	self system2:LxxBarebonesSystem new.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2. 
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system1) system identicalTo: self system1.
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system2) system identicalTo: self system2.

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system2.
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self system1.
	self assert: LcsDomainObject isSlotModelReleased not.


]

{ #category : #tests }
LxxBarebonesSystemTest >> testSystemSuspend [
	| numberOfSystems numberOfUnitsOfWork |
	
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	self system1: LxxBarebonesSystem new.
	self assert: LcsDomainObject isSlotModelReleased not.
	self system2: LxxBarebonesSystem new.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2. 
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system1) system identicalTo: self system1.
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system2) system identicalTo: self system2.

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system2.
	LcsApplicationEnvironment suspendCurrentSystem.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self system1.
	self assert: LcsDomainObject isSlotModelReleased not.



]
