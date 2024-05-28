Class {
	#name : #GtPharoBehaviorCoderViewModel,
	#superclass : #GtSingleCoderViewModel,
	#instVars : [
		'definitionCoderUIModel',
		'currentAddOns'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> computeAddOns [
	<return: #TAsyncPromise>
	^ [ self syncComputeAddOnsFor: coderModel ] asAsyncFuture
		await: self class addOnsExecutionConfiguration
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> definitionCoderUIModel [
	^ definitionCoderUIModel
		ifNil: [ self coder definitionCoder asCoderViewModel ]
		ifNotNil: [ definitionCoderUIModel ]
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> elementClass [
	^ GtPharoBehaviorCoderElement
]

{ #category : #initialization }
GtPharoBehaviorCoderViewModel >> initialize [
	super initialize.
	extraAddOns := GtCoderAddOns new
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> mainActions [
	^ currentAddOns ifNil: [ #() ] ifNotNil: [ currentAddOns mainActions ]
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> onAddOnsChanged: arg1 [
	currentAddOns := arg1.
	self
		announce: (GtPharoBehaviorCoderViewModelAddonsChangedAnnouncement new
				pharoBehaviorCoderViewModel: self)
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> onCoderModelChanged [
	super onCoderModelChanged.
	addOnPromise := nil.
	self ensureAddOns
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> previews [
	^ currentAddOns ifNil: [ #() ] ifNotNil: [ currentAddOns previews ]
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> protocols [
	^ self coderModel behavior protocols
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> syncComputeAddOnsFor: arg1 [
	| tmp1 tmp2 |
	tmp2 := arg1
			pragmasNamed: GtCoderModel astExtensionsPragma
			inHierarchy: arg1 class.
	tmp1 := arg1 newAddOns.
	tmp1 addAddOns: arg1 addOns.
	arg1 initializeAddOns: tmp1 viewModel: self.
	tmp2
		reverseDo: [ :arg2 | 
			[ arg1
				perform: arg2 methodSelector
				withEnoughArguments: {tmp1.
						self} ]
				on: Error
				do: [ :arg3 | 
					| tmp4 |
					arg3 emit.
					tmp4 := NonInteractiveTranscript stderr.
					tmp4
						nextPut: $[;
						print: arg2 method printString;
						nextPut: $];
						space;
						print: arg3;
						cr ] ].
	tmp1
		addAddOns: extraAddOns;
		markAsUpdated.
	^ tmp1
]
