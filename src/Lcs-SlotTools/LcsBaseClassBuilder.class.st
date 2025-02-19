Class {
	#name : #LcsBaseClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'newClassName',
		'targetPackageName',
		'targetSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsBaseClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #accessing }
LcsBaseClassBuilder class >> targetSuperclassName [
	^ nil
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> addModelAssociationsTo: aCollection [
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> addModelClassesTo: aCollection [
	aCollection addAll: self newClassName asClass withAllSuperclasses
]

{ #category : #printing }
LcsBaseClassBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: self classCreationString
]

{ #category : #asserting }
LcsBaseClassBuilder >> assertInstalled [
	self shouldnt: [ self newClassName asClass ] raise: NotFound
]

{ #category : #asserting }
LcsBaseClassBuilder >> assertNotInstalled [
	self should: [ self newClassName asClass ] raise: NotFound
]

{ #category : #'method code source' }
LcsBaseClassBuilder >> classCreationString [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self targetSuperclassName
			with: self newClassName
			with: self targetPackageName
]

{ #category : #uninstall }
LcsBaseClassBuilder >> clearTargetClass: aClass [
	self installedClass == aClass
		ifTrue: [ self installedClass: nil ]
]

{ #category : #refactorings }
LcsBaseClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #asserting }
LcsBaseClassBuilder >> executeShould: aBlock inScopeOf: anExceptionalEvent [
	^ [ aBlock value.
		false ] on: anExceptionalEvent do: [ :ex | ex return: true ]
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> gtClassViewOn: aView [
	<gtView>
	self installedClass isNil ifTrue: [ 
		^ aView list
			title: self newClassName;
			priority: 200;
			items: [ {'Not yet created'} ];
			yourself ].
	^ aView explicit
		title: 'Installed(' , self installedClass name , ')';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self installedClass) disablePlayPage beNormalLevel ];
		yourself
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
	
]

{ #category : #initialize }
LcsBaseClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #initialize }
LcsBaseClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseClassBuilder >> installCode [
	self addRefactoring: (RBAddClassChange definition: self classCreationString) execute.
	self installedClass: self refactorings last changeClass.
	self beCodeInstalled
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #printing }
LcsBaseClassBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Create class: ';
		nextPutAll: self newClassName asString;
		nextPutAll: ' as subclass of ';
		nextPutAll: self targetSuperclassName displayString
]

{ #category : #building }
LcsBaseClassBuilder >> removeReferencesFromSubsequentSteps [
	self parent isNil ifTrue: [ ^ self ].
	self parent inStepsAfter: self removeTargetClass: self installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #asserting }
LcsBaseClassBuilder >> should: aBlock raise: anExceptionalEvent [
	^ self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent)
]

{ #category : #asserting }
LcsBaseClassBuilder >> shouldnt: aBlock raise: anExceptionalEvent [
	self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent) not
]

{ #category : #asking }
LcsBaseClassBuilder >> stepNumber [
	^ self parent isNil 
		ifTrue: [ '1']
		ifFalse: [ (self parent indexOf: self) printString ]
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName: aString [
	targetPackageName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName [
	^ targetSuperclassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName: aString [
	targetSuperclassName := aString
]

{ #category : #running }
LcsBaseClassBuilder >> tearDown [
	self uninstall
]

{ #category : #command }
LcsBaseClassBuilder >> uninstall [
	self installedClass ifNil: [ ^ self ].
	self currentSystem removeClassFromSlotModel: self installedClass.
	self removeReferencesFromSubsequentSteps.
	self reverseRefactorings.
	self installedClass: nil
]

{ #category : #command }
LcsBaseClassBuilder >> updateSlotModel [
	self installedClass initializeSlotModel
]

{ #category : #command }
LcsBaseClassBuilder >> verifyCodeInstallation [
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self currentSystem notNil ifTrue: [
		self assert: self installedClass slotModel isNil description: 'The class has been created but not yet installed in a system'].
	self assert: self installedClass package name equals: self targetPackageName.
]

{ #category : #command }
LcsBaseClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self assert: self installedClass slotModel  notNil.
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: (self currentSystem systemSlotModel hasSlotModelForClass: self installedClass)
]

{ #category : #command }
LcsBaseClassBuilder >> verifyUninstall [
	self assert: self installedClass isNil
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> viewCodeButton [
	self installedClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self installedClass 
]
