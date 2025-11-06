Class {
	#name : #LcsBaseClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'newClassName',
		'targetPackageName',
		'targetSuperclassName',
		'newClassAlreadyExists'
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
LcsBaseClassBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetSuperclassName.	"self addSuperclassTo: classesModel."
	self addProposedClassTo: aUmlModel
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> addProposedClassTo: classesModel [
	| proposedClass |
	proposedClass := classesModel proposedClassModelFor: self newClassName.
	self targetSuperclassName notNil
		ifTrue: [ proposedClass modelSuperclassName: self targetSuperclassName ]
]

{ #category : #printing }
LcsBaseClassBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: (
		self newClassAlreadyExists 
			ifTrue: [self newClassName , ' Class already exists']
			ifFalse: [self classCreationString]).
	self jobSteps hasJobSteps ifTrue: [ aStream cr; cr ].
	self jobSteps addRefactoringTextDetailsTo: aStream
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> addSuperclassTo: classesModel [
	self targetSuperclass
		ifNil: [ self targetSuperclassName ifNotNil: [ 
				classesModel proposedClassModelFor: self targetSuperclassName ] ]
		ifNotNil: [ :class | classesModel addClassModelForExisting: class ]
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

	self assert: self targetSuperclassName isString.
	self assert: self newClassName isString.
	self assert: self targetPackageName isString.
	
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
			actionUpdateButton;
			yourself ].
	^ aView explicit
		title: 'Installed(' , self installedClass name , ')';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self installedClass) disablePlayPage beNormalLevel ];
		actionUpdateButton;
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
	self targetSuperclassName: self class targetSuperclassName.
	self newClassAlreadyExists: false
]

{ #category : #initialize }
LcsBaseClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseClassBuilder >> installClass [
	self newClassAlreadyExists ifTrue: [ ^ self ].
	self addRefactoring: (RBAddClassChange definition: self classCreationString) execute.
	self installedClass: self refactorings last changeClass
]

{ #category : #build }
LcsBaseClassBuilder >> installCode [
	super installCode.
	self newClassAlreadyExists ifFalse: [
		self installClass ].
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
LcsBaseClassBuilder >> newClassAlreadyExists [
	^ newClassAlreadyExists
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassAlreadyExists: anObject [
	newClassAlreadyExists := anObject
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> newTargetClassName: aString [
	self newClassName: aString.
	self newClassAlreadyExists: (
		[
			self installedClass:self newClassName asClass.
			true ]
			on: NotFound
			do: [ :s | s return: false ])  
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

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName: aString [
	targetPackageName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclass [
	^ [ self targetSuperclassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
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
	super uninstall.
	self installedClass ifNil: [ ^ self ].
	self newClassAlreadyExists ifTrue: [ ^ self ].
	self currentSystem ifNotNil: [
		self currentSystem removeClassFromSlotModel: self installedClass.
		self removeReferencesFromSubsequentSteps.
		self currentUnitOfWork removeAddOf: self installedClass].
	self reverseRefactorings.
	self installedClass: nil
]

{ #category : #command }
LcsBaseClassBuilder >> updateSlotModel [
	super updateSlotModel.
	self newClassAlreadyExists ifTrue: [
		self installedClass verifySuperclassesHaveInitializedSlotModel.
		^ self].
	self installedClass initializeSlotModel
]

{ #category : #command }
LcsBaseClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self assert: self installedClass package name equals: self targetPackageName
]

{ #category : #command }
LcsBaseClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	super verifySlotModelUpdatesMadeByBuilder.
	self assert: self installedClass slotModel  notNil.
	self currentSystem isNil ifTrue: [ ^ self ].
	self assert: (self currentSystem systemSlotModel hasSlotModelForClass: self installedClass)
]

{ #category : #command }
LcsBaseClassBuilder >> verifyUninstall [
	super verifyUninstall.
	self assert: self installedClass isNil
]

{ #category : #'gt views' }
LcsBaseClassBuilder >> viewCodeButton [
	self installedClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self installedClass 
]
