Class {
	#name : 'LcsSlotGetterAndSetterBuilder',
	#superclass : 'LcsSlotDetailBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> _installCode [
	super _installCode.
	self isAlreadyImplementedInSuperclass ifTrue: [ ^ self ].
	self addRefactoring: (
		RBAddMethodChange
			compile: self getterSource
			in: self targetClass
			classified: #accessing)
				execute.
	self addRefactoring: (
		RBAddMethodChange
			compile: self setterSource
			in: self targetClass
			classified: #accessing)
				execute.
	self beCodeInstalled
]

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: (self targetClass canUnderstand: self getterSelector).
	self assert: (self targetClass canUnderstand: self setterSelector).
]

{ #category : 'printing' }
LcsSlotGetterAndSetterBuilder >> addGetterAndSetterSourceCodeTo: aStream [
	aStream
		nextPutAll: self getterSource;
		cr;
		cr;
		nextPutAll: self setterSource
]

{ #category : 'printing' }
LcsSlotGetterAndSetterBuilder >> addRefactoringTextDetailsTo: aStream [
	self slotName isNil
		ifTrue: [ aStream
				nextPutAll: '<missing> slot name - no getter and setter will be implemented'.
			^ self ].
	self targetClass isNil
		ifTrue: [ 
			aStream
				nextPutAll: (self targetClassName ifNil: ['<missing target class name>'] ifNotNil: [ self targetClassName , ' not yet created']);
				nextPutAll: '. This is the proposed accessor and getter code:';
				cr;
				cr.
			self addGetterAndSetterSourceCodeTo: aStream.
			^ self ].

	self isAlreadyImplementedInTargetClass
		ifTrue: [ aStream
				nextPutAll: (self slotName ifNil: [ '<missing>' ]);
				nextPutAll: ' - getter and setter are already implemented in ';
				nextPutAll: self targetClassName displayString.
			^ self ].
	self isAlreadyImplementedInSuperclass
		ifTrue: [ aStream
				nextPutAll: 'The getter and setter for ''';
				nextPutAll: self slotName asString;
				nextPutAll: '''are already implemented in superclass'.
			^ self ].
	self addGetterAndSetterSourceCodeTo: aStream
]

{ #category : 'gt views' }
LcsSlotGetterAndSetterBuilder >> getterAndSetterMethodsFilter [
	| classFilter |
	classFilter := (GtSearchInheritedMethodsFilter forClass: self targetClass)
			withSuperclassesUpTo: #LcsBaseDomainObject asClass.
	^ classFilter & (self getterSelector gtImplementors | self setterSelector gtImplementors)
]

{ #category : 'selector' }
LcsSlotGetterAndSetterBuilder >> getterSelector [
	^ self slotName asString asSymbol
]

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> getterSource [
	^'<1s>
	^ self slotVarNamed: ''<1s>''' expandMacrosWith: self slotName
]

{ #category : 'gt views' }
LcsSlotGetterAndSetterBuilder >> gtClassViewOn: aView [
	<gtView>
	^ aView text
		title: 'No Target Class';
		priority: 200;
		text: 'No target class';
		actionUpdateButton
]

{ #category : 'gt views' }
LcsSlotGetterAndSetterBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : 'gt views' }
LcsSlotGetterAndSetterBuilder >> gtSlotAccessorImplementorsFor: aView [
	<gtView>
	self targetClass isNil ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Implementor(Slot Accessors)';
		priority: 200;
		stencil: [ self getterAndSetterMethodsFilter ]
]

{ #category : 'testing' }
LcsSlotGetterAndSetterBuilder >> isAlreadyImplementedInSuperclass [
	self targetClass isNil ifTrue: [ ^ false ].
	^ self targetClass superclass canUnderstand: self getterSelector
]

{ #category : 'testing' }
LcsSlotGetterAndSetterBuilder >> isAlreadyImplementedInTargetClass [
	self targetClass isNil ifTrue: [ ^ false ].
	^ self targetClass canUnderstand: self slotName asSymbol
]

{ #category : 'printing' }
LcsSlotGetterAndSetterBuilder >> jobStepActionDescription [
	^ 'Install getter and setter for'
]

{ #category : 'selector' }
LcsSlotGetterAndSetterBuilder >> setterSelector [
	^ (self slotName asString , ':') asSymbol
]

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> setterSource [
	^'<1s>: anObject
	self slotVarNamed: ''<1s>'' put: anObject' expandMacrosWith: self slotName
]

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> uninstall [
	super uninstall.
	self targetClass ifNil: [ ^ self ].
	self targetClass removeSelector: self getterSelector.
	self targetClass removeSelector: self setterSelector
]

{ #category : 'command' }
LcsSlotGetterAndSetterBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].
	self assert: (self targetClass canUnderstand: self getterSelector) not.
	self assert: (self targetClass canUnderstand: self setterSelector) not.
]
