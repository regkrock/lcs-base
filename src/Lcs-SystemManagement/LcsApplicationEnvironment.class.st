Class {
	#name : #LcsApplicationEnvironment,
	#superclass : #LcsObject,
	#instVars : [
		'systemManager',
		'unitsOfWorkManager',
		'status'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> createCurrentSystemFor: aSystemClass [ 
	self verifyApplicationEnvironment.
	^ self environmentDo: [ :env | env createCurrentSystemFor: aSystemClass ]
	
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> createUnitOfWork [
	^ self environmentDo: [ :env | env createUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> currentApplicationEnvironment [
	^ self singleton
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> currentSystem [
	^ self environmentObject: [ :env | env currentSystem ]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> currentSystem: aSystem [ 
	self environmentDo: [  :env | env currentSystem: aSystem ]
]

{ #category : #'unit of work' }
LcsApplicationEnvironment class >> currentUnitOfWork [
	^ self environmentObject: [ :env | env currentUnitOfWork ]
]

{ #category : #running }
LcsApplicationEnvironment class >> ensureInitialized [
	self hasInitializedEnvironment ifFalse: [ self initializeEnvironment ].
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> environmentDo: aBlock [
	^ self currentApplicationEnvironment ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> environmentDoesNotHave: aBlock [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> environmentHas: aBlock [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> environmentObject: aBlock [
	^ self currentApplicationEnvironment ifNil: [ nil ] ifNotNil: aBlock 
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> gtEnvironmentFor: aView [
		<gtView>
	self hasInitializedEnvironment ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Application Environment';
		priority: 10;
		items: [ Array with: self currentApplicationEnvironment ];
		column: 'Initialized' text: [ self hasInitializedEnvironment printString ] width: 80;
		column: 'Has Current System' text: [ self systemManager hasCurrentSystem printString ] width: 120;
		column: 'Number Of Systems' number: [ self systemManager numberOfSystems ] ;
		column: 'Has Current Unit Of Work' text: [ self unitsOfWorkManager hasCurrentUnitOfWork printString ] width: 120;
		column: 'Number Of Units Of Work' number: [ self unitsOfWorkManager numberOfUnitsOfWork ];
		yourself
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasCurrentUnitOfWork [
	^ self environmentHas: [:env |  env hasCurrentUnitOfWork ]
	"^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [:env |  self currentApplicationEnvironment hasCurrentUnitOfWork ]"
	

]

{ #category : #testing }
LcsApplicationEnvironment class >> hasInitializedEnvironment [
	^ self currentApplicationEnvironment notNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentSystem [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: [ self currentApplicationEnvironment currentSystem isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentUnitOfWork [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: [ self currentApplicationEnvironment currentUnitOfWork isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoninitializedEnvironment [
	^ self currentApplicationEnvironment isNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasSystemManager [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasSystemManager ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasUnitOfWorkManager [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasUnitOfWorkManager ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasUnitsOfWorkManager [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasUnitsOfWorkManager ]
]

{ #category : #initiailize }
LcsApplicationEnvironment class >> initializeEnvironment [
	self singleton notNil ifTrue: [ self error: 'Environment is already initialized' ].
	LcsSmalltalkConfiguration gsSystemClass abortTransaction.
	self singleton: self basicNew initialize.
	LcsSmalltalkConfiguration gsSystemClass commitTransaction.
	^ self currentApplicationEnvironment
]

{ #category : #'running\t\t' }
LcsApplicationEnvironment class >> isInActiveStatus [
	^ self environmentHas: [ :env | env isInActiveStatus]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> makeSystemCurrent: aSystem [
	self environmentDo: [ :env | env makeSystemCurrent: aSystem ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> new [
	"Use #initializeEnvironment instead"
	self shouldNotImplement
]

{ #category : #release }
LcsApplicationEnvironment class >> releaseEnvironment [
	self environmentDo: [ :env | 
		 env releaseEnvironment.
		 self singleton: nil ].
	
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> removeCurrentSystem [
	self environmentDo: [  :env  | env removeCurrentSystem ]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> removeCurrentUnitOfWork [
	self environmentDo: [ :env | env  removeCurrentUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> restoreToCurrentApplicationEnvironment: anApplicationEnvironment [
	self singleton: anApplicationEnvironment.
	self environmentDo: [ :env | env restoreEnvironment ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton [
	^ singleton
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton: anObject [
	singleton := anObject
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> suspendCurrentApplicationEnvironment [
	| currentApplicationEnvironment |
	currentApplicationEnvironment := self currentApplicationEnvironment.
	self environmentDo: [ :env | env suspendEnvironment ].
	self singleton: nil.
	
	self assert: (currentApplicationEnvironment ifNil: [ ^ true ] ifNotNil:  [ currentApplicationEnvironment isInSuspendedStatus]).
	^currentApplicationEnvironment
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> suspendCurrentSystem [
	^ self environmentDo: [ :env | env suspendCurrentSystem ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> suspendEnvironment [
	self environmentDo: [ :env | env suspendEnvironment ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> systemManager [
	^ self environmentObject: [ :env | env systemManager ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> unitsOfWorkManager [
	^ self environmentObject: [ :env | env unitsOfWorkManager ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> verifyApplicationEnvironment [
	self hasInitializedEnvironment
		ifFalse: [ LcsApplicationEnivronmentNotInitializedError
				signal: 'Unable to create a system because application environment is not initialized' ]
]

{ #category : #system }
LcsApplicationEnvironment >> createCurrentSystemFor: aSystemClass [
	^ self systemManager createCurrentSystemFor: aSystemClass
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> createUnitOfWork [
	^ self unitsOfWorkManager createUnitOfWork
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem [
	^ self systemManager currentSystem
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem: aSystem [
	^ self systemManager currentSystem: aSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #'gt view' }
LcsApplicationEnvironment >> gtEnvironmentFor: aView [
		<gtView>
	^ aView columnedList
		title: 'Application Environment';
		priority: 10;
		items: [ Array with: self ];
		column: 'Initialized' text: [ self class hasInitializedEnvironment printString ] width: 80;
		column: 'Has Current System' text: [ self systemManager hasCurrentSystem printString ] width: 120;
		column: 'Number Of Systems' number: [ self systemManager numberOfSystems ] ;
		column: 'Has Current Unit Of Work' text: [ self unitsOfWorkManager hasCurrentUnitOfWork printString ] width: 120;
		column: 'Number Of Units Of Work' number: [ self unitsOfWorkManager numberOfUnitsOfWork ];
		yourself
		


]

{ #category : #testing }
LcsApplicationEnvironment >> hasCurrentUnitOfWork [
	^ self unitsOfWorkManager hasCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasNoCurrentUnitOfWork [
	^ self unitsOfWorkManager hasNoCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasSystemManager [
	^ self systemManager notNil
]

{ #category : #testing }
LcsApplicationEnvironment >> hasUnitOfWorkManager [
	^ self unitsOfWorkManager notNil
]

{ #category : #testing }
LcsApplicationEnvironment >> hasUnitsOfWorkManager [
	^self unitsOfWorkManager notNil
]

{ #category : #initialize }
LcsApplicationEnvironment >> initialize [
	super initialize.
	self systemManager: (LcsSystemManager newOn: self).
	self unitsOfWorkManager: (LcsUnitsOfWorkManager newOn: self).
	self status: (LcsApplicationEnvironmentActiveStatus newOn: self)
]

{ #category : #testing }
LcsApplicationEnvironment >> isInActiveStatus [
	^self status isInActiveStatus
]

{ #category : #testing }
LcsApplicationEnvironment >> isInSActiveStatus [
	^self status isInSActiveStatus
]

{ #category : #testing }
LcsApplicationEnvironment >> isInSuspendedStatus [
	^self status isInSuspendedStatus
]

{ #category : #system }
LcsApplicationEnvironment >> makeSystemCurrent: aSystem [
	self systemManager makeSystemCurrent: aSystem
]

{ #category : #'release\t' }
LcsApplicationEnvironment >> releaseEnvironment [
	self systemManager ifNotNil: [ :manager | manager releaseEnvironment ].
	self unitsOfWorkManager ifNotNil: [ :manager | manager releaseEnvironment ].
	LcsObject releaseEnvironment  
]

{ #category : #system }
LcsApplicationEnvironment >> removeCurrentSystem [
	^ self systemManager removeCurrentSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> removeCurrentUnitOfWork [
	^ self unitsOfWorkManager removeCurrentUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> restoreEnvironment [
	self status restoreEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment >> status [
	^ status
]

{ #category : #accessing }
LcsApplicationEnvironment >> status: anObject [
	status := anObject
]

{ #category : #system }
LcsApplicationEnvironment >> suspendCurrentSystem [
	^ self systemManager suspendCurrentSystem
]

{ #category : #system }
LcsApplicationEnvironment >> suspendEnvironment [
	^ self status suspendEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager [
	^ systemManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager: anObject [
	systemManager := anObject
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager [
	^ unitsOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager: anObject [
	unitsOfWorkManager := anObject
]
