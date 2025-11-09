Class {
	#name : #LcsApplicationEnvironment,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'unitsOfWorkManager',
		'status',
		'systemsManager'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentDo: aBlock [
	^ self currentApplicationEnvironment ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentDoesNotHave: aBlock [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentHas: aBlock [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentObject: aBlock [
	^ self currentApplicationEnvironment ifNil: [ nil ] ifNotNil: aBlock 
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> applicationEnvironmentViewChildren [
	^ {
		"LcsApplicationEnvironmentViewItem newOn: self label: 'Initialized' item: self currentApplicationEnvironment notNil."
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current' item: self currentApplicationEnvironment}
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> createCurrentSystemFor: aSystemClass [ 
	self verifyApplicationEnvironment.
	^ self applicationEnvironmentDo: [ :env | env createCurrentSystemFor: aSystemClass ]
	
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> createUnitOfWork [
	^ self applicationEnvironmentDo: [ :env | env createUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> currentApplicationEnvironment [
	^ LcsApplicationEnvironment singleton
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> currentSystem [
	^ self applicationEnvironmentObject: [ :env | env currentSystem ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> currentSystem: aSystem [ 
	self applicationEnvironmentDo: [  :env | env currentSystem: aSystem ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> currentUnitOfWork [
	^ self applicationEnvironmentObject: [ :env | env currentUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> deleteCurrentAndMakeCurrent: aSystem [
	self applicationEnvironmentDo: [ :env | env deleteCurrentAndMakeCurrent: aSystem ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> ensureActiveApplicationEnvironment [
	self hasInitializedApplicationEnvironment
		ifFalse: [ self initializeApplicationEnvironment] 
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> ensureCurrentsystemIsMainSystem [
	self ensureActiveApplicationEnvironment.
	self currentSystem 
		ifNil: [ self createNewMainSystem ]
		ifNotNil: [ self currentSystem isMainSystem ifFalse: [ self createNewMainSystem ] ].
	self assert: self currentSystem isMainSystem.
	^ self currentSystem
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> ensureCurrentsystemIsPrototypeSystem [
	self ensureActiveApplicationEnvironment.
	self currentSystem 
		ifNil: [ self createNewPrototypeSystem ]
		ifNotNil: [ self currentSystem isPrototypeSystem ifFalse: [ self createNewPrototypeSystem ] ].
	self assert: self currentSystem isPrototypeSystem.
	^ self currentSystem
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> ensureInitialized [
	self hasInitializedApplicationEnvironment ifFalse: [ self initializeApplicationEnvironment ].
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> gtApplicationEnvironmentFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedTree
		title: 'Application Environment';
		priority: 1;
		expandUpTo: 4;
		items: [ self applicationEnvironmentViewChildren ];
		children: [ :each | each children ];
		column: 'Option' translated
			text: [ :each | each label displayString ]
			width: 200;
		column: 'Value' translated text: [ :each | each item displayString ] width: 400;
		column: '' stencil: [ :viewItem :row :column | viewItem startSuspendSystemButton ] width: 70;
		column: '' stencil: [ :viewItem | viewItem stopButton ] width: 70; 
		send: #item;
		actionButtonIcon: BrGlamorousVectorIcons shutdown 
			tooltip: 'Start/Stop environment'
			action: [ :aButton :aTab | 
				self toggleStartStop.
				aTab viewContentElement phlow update ];
		actionUpdateButton;
		yourself
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> gtStartStopActionFor: anAction [
	"<gtClassAction>"
	^ anAction button
		icon: BrGlamorousVectorIcons shutdown;
		tooltip: 'Start/stop the application environment';
		priority: 10;
		action: [ self toggleStartStop ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasCurrentSystem [
	^ self applicationEnvironmentHas: [ :env | env currentSystem notNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasCurrentUnitOfWork [
	^ self applicationEnvironmentHas: [:env |  env hasCurrentUnitOfWork ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasInitializedApplicationEnvironment [
	^ self currentApplicationEnvironment notNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentSystem [
	^ self applicationEnvironmentDoesNotHave: [ :env | env currentSystem isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentUnitOfWork [
	^ self applicationEnvironmentDoesNotHave: [ :env | env currentUnitOfWork isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoninitializedApplicationEnvironment [
	^ self currentApplicationEnvironment isNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasSystemsManager [
	^ self applicationEnvironmentHas: [ :env | env hasSystemsManager ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasUnitsOfWorkManager [
	^ self applicationEnvironmentHas: [ :env | env hasUnitsOfWorkManager ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> initializeApplicationEnvironment [
	self currentApplicationEnvironment ifNotNil: [ self error: 'Environment is already initialized' ].
	"System abortTransaction."
	self singleton: self basicNew initialize.
	"System commitTransaction."
	^ self currentApplicationEnvironment
]

{ #category : #testing }
LcsApplicationEnvironment class >> isInActiveStatus [
	^ self applicationEnvironmentHas: [ :env | env isInActiveStatus]
]

{ #category : #'start-stop' }
LcsApplicationEnvironment class >> isRunning [
	^ self hasInitializedApplicationEnvironment
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> makeSystemCurrent: aSystem [
	self applicationEnvironmentDo: [ :env | env makeSystemCurrent: aSystem ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> new [
	"Use #initializeEnvironment instead"
	self shouldNotImplement
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> releaseApplicationEnvironment [
	self applicationEnvironmentDo: [ :env | 
		 env releaseApplicationEnvironment.
		 self singleton: nil ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> removeClassesNamed: classNames [ 
	| classesToBeRemoved |
	classesToBeRemoved := (classNames collect: [:each | 
		[ each asClass ] on: NotFound do: [ :s | s return: nil] ]) reject: [ :e | e isNil].
	classesToBeRemoved do: [ :eachClass | (RBRemoveClassChange removeClassName: eachClass name) execute ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> removeCurrentSystem [
	self applicationEnvironmentDo: [  :env  | env removeCurrentSystem ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> removeCurrentUnitOfWork [
	self applicationEnvironmentDo: [ :env | env  removeCurrentUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> resetApplicationEnvironment [
	self releaseApplicationEnvironment.
	self initializeApplicationEnvironment.
	^ self currentApplicationEnvironment
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> restoreToCurrentApplicationEnvironment: anApplicationEnvironment [
	self singleton: anApplicationEnvironment.
	self applicationEnvironmentDo: [ :env | env restoreApplicationEnvironment ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton [
	^ singleton
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton: anApplicationEnvironment [
	singleton := anApplicationEnvironment
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> suspendApplicationEnvironment [
	| suspensionCandidate |
	suspensionCandidate := self currentApplicationEnvironment.
	self applicationEnvironmentDo: [ :env | env suspendApplicationEnvironment ].
	self singleton: nil.
	^suspensionCandidate
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> suspendCurrentSystem [
	^ self applicationEnvironmentDo: [ :env | env suspendCurrentSystem ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> systemsManager [
	^ self applicationEnvironmentObject: [ :env | env systemsManager ]
]

{ #category : #'start-stop' }
LcsApplicationEnvironment class >> toggleStartStop [
	self isRunning
		ifTrue: [ self releaseApplicationEnvironment ]
		ifFalse: [ self initializeApplicationEnvironment ]
]

{ #category : #'application environment - system' }
LcsApplicationEnvironment class >> unitsOfWorkManager [
	^ self applicationEnvironmentObject: [ :env | env unitsOfWorkManager ]
]

{ #category : #system }
LcsApplicationEnvironment >> applicationEnvironment [
	^ self
]

{ #category : #'gt views' }
LcsApplicationEnvironment >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Status' item: self status.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Systems Manager' item: self systemsManager.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Units Of Work' item: self unitsOfWorkManager.}
]

{ #category : #system }
LcsApplicationEnvironment >> createCurrentSystemFor: aSystemClass [
	^ self systemsManager createCurrentSystemFor: aSystemClass
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> createUnitOfWork [
	^ self unitsOfWorkManager createUnitOfWork
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem [
	^ self systemsManager currentSystem
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem: aSystem [
	^ self systemsManager currentSystem: aSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #system }
LcsApplicationEnvironment >> deleteCurrentAndMakeCurrent: aSystem [
	self 
		removeCurrentSystem;
		makeSystemCurrent: aSystem
]

{ #category : #'gt views' }
LcsApplicationEnvironment >> gtApplicationEnvironmentFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Application Environment';
		priority: 10;
		expandUpTo: 3;
		items: [ self applicationEnvironmentViewChildren ];
		children: [ :viewItem | viewItem children ];
		column: 'Option'
			text: [ :viewItem | viewItem label ]
			width: 200;
		column: 'Value' text: [ :viewItem | viewItem item displayString ] width: 300;
		column: '' stencil: [ :viewItem | viewItem startSuspendSystemButton] width: 70;
		column: '' stencil: [ :viewItem | viewItem stopSystemButton] width: 70;
		send: #item;
		yourself
]

{ #category : #'gt views' }
LcsApplicationEnvironment >> gtSystemsManagerFor: aView [
	<gtView>
	^ aView forward
		title: 'System Manager';
		priority: 11;
		object: [ self systemsManager ];
		view: #gtSystemsManagerFor:
		yourself
]

{ #category : #'gt views' }
LcsApplicationEnvironment >> gtUnitsOfWorkManagerFor: aView [
	<gtView>
	^ aView forward
		title: 'Units Of Work';
		priority: 12;
		object: [ self unitsOfWorkManager ];
		view: #gtUnitsOfWorkManagerFor:
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
LcsApplicationEnvironment >> hasSystemsManager [
	^ self systemsManager notNil
]

{ #category : #testing }
LcsApplicationEnvironment >> hasUnitsOfWorkManager [
	^self unitsOfWorkManager notNil
]

{ #category : #initialize }
LcsApplicationEnvironment >> initialize [
	super initialize.
	self systemsManager: (LcsSystemsManager newOn: self).
	self unitsOfWorkManager: (LcsUnitsOfWorkManager newOn: self).
	self status: (LcsApplicationEnvironmentActiveStatus newOn: self)
]

{ #category : #testing }
LcsApplicationEnvironment >> isInActiveStatus [
	^self status isInActiveStatus
]

{ #category : #testing }
LcsApplicationEnvironment >> isInSuspendedStatus [
	^self status isInSuspendedStatus
]

{ #category : #system }
LcsApplicationEnvironment >> makeSystemCurrent: aSystem [
	self systemsManager makeSystemCurrent: aSystem
]

{ #category : #system }
LcsApplicationEnvironment >> releaseApplicationEnvironment [
	self systemsManager ifNotNil: [ :manager | manager releaseApplicationEnvironment ].
	self unitsOfWorkManager ifNotNil: [ :manager | manager releaseApplicationEnvironment ].
	LcsBaseDomainObject releaseApplicationEnvironment  
]

{ #category : #system }
LcsApplicationEnvironment >> removeCurrentSystem [
	^ self systemsManager removeCurrentSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> removeCurrentUnitOfWork [
	^ self unitsOfWorkManager removeCurrentUnitOfWork
]

{ #category : #system }
LcsApplicationEnvironment >> restoreApplicationEnvironment [
	self status restoreApplicationEnvironment
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
LcsApplicationEnvironment >> suspendApplicationEnvironment [
	^ self status suspendApplicationEnvironment
]

{ #category : #system }
LcsApplicationEnvironment >> suspendCurrentSystem [
	^ self systemsManager suspendCurrentSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemsManager [
	^ systemsManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemsManager: anObject [
	systemsManager := anObject
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager [
	^ unitsOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager: anObject [
	unitsOfWorkManager := anObject
]
