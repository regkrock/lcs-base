Class {
	#name : 'LcsMethodBuilder',
	#superclass : 'LcsCodeBuilderStep',
	#instVars : [
		'categoryName',
		'selector',
		'targetClass',
		'targetClassName',
		'isClassMethod'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'command' }
LcsMethodBuilder >> _installCode [
	super _installCode.
	self
		addRefactoring: (RBAddMethodChange
				compile: self methodSource
				in: self compileTargetClass
				classified: self categoryName asSymbol) execute.
	self beCodeInstalled
]

{ #category : 'command' }
LcsMethodBuilder >> _verifyCodeInstallation [
	self assert: (self compileTargetClass canUnderstand: self selector asSymbol )
]

{ #category : 'printing' }
LcsMethodBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream 
		nextPutAll: (self targetClassName ifNil: [ '<missing target class name>']).
	self isClassMethod 
		ifTrue: [aStream nextPutAll:' class >>']
		ifFalse: [ aStream nextPutAll: ' >> '].
	aStream nextPutAll: self methodSource
]

{ #category : 'command' }
LcsMethodBuilder >> beClassMethod [
	self isClassMethod: true
]

{ #category : 'command' }
LcsMethodBuilder >> beInstanceMethod [
	self isClassMethod: false
]

{ #category : 'accessing' }
LcsMethodBuilder >> categoryName [
	^ categoryName
]

{ #category : 'accessing' }
LcsMethodBuilder >> categoryName: anObject [
	categoryName := anObject
]

{ #category : 'command' }
LcsMethodBuilder >> compileTargetClass [
	^ self isClassMethod
		ifTrue: [ self targetClass class ]
		ifFalse: [ self targetClass ]
]

{ #category : 'gt views' }
LcsMethodBuilder >> gtClassViewOn: aView [
	<gtView>
	self targetClass isNil ifTrue: [ 
		^ aView list
			title: self targetClassName;
			priority: 200;
			items: [ {'Not yet created'} ];
			actionUpdateButton;
			yourself ].
	^ aView explicit
		title: 'Installed(' , self targetClass name , ')';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self targetClass) disablePlayPage beNormalLevel ];
		actionUpdateButton;
		yourself
]

{ #category : 'initialize' }
LcsMethodBuilder >> initialize [
	super initialize.
	self isClassMethod: false.
	self categoryName: #'generated method'
]

{ #category : 'accessing' }
LcsMethodBuilder >> isClassMethod [
	^ isClassMethod
]

{ #category : 'accessing' }
LcsMethodBuilder >> isClassMethod: aBoolean [ 
	isClassMethod := aBoolean
]

{ #category : 'command' }
LcsMethodBuilder >> methodSource [
	self subclassResponsibility
]

{ #category : 'printing' }
LcsMethodBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install #';
		nextPutAll: self selector asString;
		nextPutAll: ' in ';
		nextPutAll: self targetClassName displayString.
	self isClassMethod ifTrue: [
		aStream 
			nextPutAll: ' class']
]

{ #category : 'accessing' }
LcsMethodBuilder >> selector [
	^ selector
]

{ #category : 'accessing' }
LcsMethodBuilder >> selector: anObject [
	selector := anObject
]

{ #category : 'accessing' }
LcsMethodBuilder >> targetClass [
	^ targetClass ifNil: [[ self targetClassName asString asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ]]
]

{ #category : 'accessing' }
LcsMethodBuilder >> targetClass: anObject [
	targetClass := anObject
]

{ #category : 'accessing' }
LcsMethodBuilder >> targetClassName [
	^ targetClassName
]

{ #category : 'accessing' }
LcsMethodBuilder >> targetClassName: anObject [
	targetClassName := anObject.
	self targetClass: nil.
]

{ #category : 'command' }
LcsMethodBuilder >> uninstall [
	super uninstall.
	self refactorings do: [ :each | each execute ]
]
