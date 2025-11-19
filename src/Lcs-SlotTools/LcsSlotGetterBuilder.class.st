Class {
	#name : 'LcsSlotGetterBuilder',
	#superclass : 'LcsSlotDetailBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'command' }
LcsSlotGetterBuilder >> _installCode [
	super _installCode.
	self isAlreadyImplementedInSuperclass ifTrue: [ ^ self ].
	self addRefactoring: (
		RBAddMethodChange
			compile: self getterSource
			in: self targetClass
			classified: #accessing)
				execute.
	self beCodeInstalled
]

{ #category : 'command' }
LcsSlotGetterBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: (self targetClass canUnderstand: self getterSelector).
]

{ #category : 'printing' }
LcsSlotGetterBuilder >> addGetterSourceCodeTo: aStream [
	aStream
		nextPutAll: self getterSource;
		cr
]

{ #category : 'printing' }
LcsSlotGetterBuilder >> addRefactoringTextDetailsTo: aStream [
	self slotName isNil
		ifTrue: [ aStream
				nextPutAll: '<missing> slot name - no getter will be implemented'.
			^ self ].
	self targetClass isNil
		ifTrue: [ 
			aStream
				nextPutAll: self targetClassName asString , ' not yet created. This is the proposed code:';
				cr;
				cr.
			self addGetterSourceCodeTo: aStream.
			^ self ].

	self isAlreadyImplementedInTargetClass
		ifTrue: [ aStream
				nextPutAll: (self slotName ifNil: [ '<missing>' ]);
				nextPutAll: ' - setter is already implemented in ';
				nextPutAll: self targetClassName displayString.
			^ self ].
	self isAlreadyImplementedInSuperclass
		ifTrue: [ aStream
				nextPutAll: 'The getter for ''';
				nextPutAll: self slotName asString;
				nextPutAll: '''is already implemented in superclass'.
			^ self ].
	self addGetterSourceCodeTo: aStream
]

{ #category : 'gt views' }
LcsSlotGetterBuilder >> getterMethodsFilter [
	| classFilter |
	classFilter := (GtSearchInheritedMethodsFilter forClass: self targetClass)
			withSuperclassesUpTo: #LcsBaseDomainObject asClass.
	^ classFilter & (self getterSelector gtImplementors)
]

{ #category : 'selector' }
LcsSlotGetterBuilder >> getterSelector [
	^ self slotName asString asSymbol
]

{ #category : 'command' }
LcsSlotGetterBuilder >> getterSource [
	^'<1s>
	^ self slotVarNamed: ''<1s>''' expandMacrosWith: self slotName
]

{ #category : 'gt views' }
LcsSlotGetterBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : 'gt views' }
LcsSlotGetterBuilder >> gtSlotAccessorImplementorsFor: aView [
	<gtView>
	self targetClass isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Accessors)';
		priority: 200;
		stencil: [ self getterMethodsFilter ]
]

{ #category : 'testing' }
LcsSlotGetterBuilder >> isAlreadyImplementedInSuperclass [
	self targetClass isNil ifTrue: [ ^ false ].
	^ self targetClass superclass canUnderstand: self getterSelector
]

{ #category : 'testing' }
LcsSlotGetterBuilder >> isAlreadyImplementedInTargetClass [
	self targetClass isNil ifTrue: [ ^ false ].
	^ self targetClass canUnderstand: self slotName asSymbol
]

{ #category : 'printing' }
LcsSlotGetterBuilder >> jobStepActionDescription [
	^ 'Install getter for'
]

{ #category : 'command' }
LcsSlotGetterBuilder >> uninstall [
	super uninstall.
	self targetClass ifNil: [ ^ self ].
	self targetClass removeSelector: self getterSelector
]

{ #category : 'command' }
LcsSlotGetterBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].
	self assert: (self targetClass canUnderstand: self getterSelector) not
]
