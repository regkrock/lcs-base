Class {
	#name : #LcsBaseSlotCreationForm,
	#superclass : #Object,
	#instVars : [
		'targetClass',
		'slotModelBuilder',
		'onReset',
		'onAccept'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #'instance creation' }
LcsBaseSlotCreationForm class >> newOn: aTarget [
	^ self new
		initializeOn: aTarget;
		yourself
]

{ #category : #callbacks }
LcsBaseSlotCreationForm >> buildJobSteps [
	self slotModelBuilder 
			initializeJobSteps;
			buildJobSteps
]

{ #category : #configuration }
LcsBaseSlotCreationForm >> builderClass [
	self subclassResponsibility
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> commitSlotBuilderChangesAction [
	^ GtMagritteAction new
		beInFutureProcess;
		beWithFutureResponse;
		action: [ :aModel :aButton :aMemento :aDescription | 
			aMemento commit.
			aModel buildJobSteps ]
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> executeModelBuilderJob [
	self slotModelBuilder execute.
	self reinitialize.
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> initialize [
	super initialize.
	self slotModelBuilder: self builderClass new
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> initializeOn: aTarget [
	self targetClass: (aTarget isClass ifTrue: [ aTarget ] ifFalse: [ aTarget class ]).
	self slotModelBuilder targetPackageName: self targetClass package name
]

{ #category : #testing }
LcsBaseSlotCreationForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = LcsCodeBuilderStep
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Update Builder';
		action: self commitSlotBuilderChangesAction;
		beEnabledOnValidOverallStatus
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteBuildAction [
	<magritteActionDescription>
	"self isSlotModelBuilderNotReified ifTrue: [ ^ nil ]."
	^ MAActionDescription new
		priority: 30;
		label: 'Build';
		isLabelVisible: false;
		beToolbarAction;
		blocIcon: BrGlamorousVectorIcons play;
		action: (
			GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aModel executeModelBuilderJob.
					aButton phlow fireViewUpdateWish ]);
		onOverallStatusChanged: (
			GtMagritteBasicAction new
				action: [ :aStatus :aButton :aMemento :aDescription |
							aStatus isChanged
								ifTrue: [ aDescription enabled: false ]
								ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ onReset ifNotNil: [ onReset value ] ] 
						on: Error do: #debug ]);
		beAlwaysEnabled
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onAccept [

	^ onAccept
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onAccept: aBlock [

	onAccept := aBlock
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onReset [
	^ onReset
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onReset: aBlock [
	onReset := aBlock
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> reinitialize [
	| target |
	target := self targetClass.
	self initialize.
	self initializeOn: target
]

{ #category : #callbacks }
LcsBaseSlotCreationForm >> slotModelBuilder [
	^ slotModelBuilder
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> slotModelBuilder: anObject [
	slotModelBuilder := anObject
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> targetClass: anObject [
	targetClass := anObject
]
