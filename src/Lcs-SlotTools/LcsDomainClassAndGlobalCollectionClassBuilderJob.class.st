"
**This builder has the following steps which does the following:**
**1)** Create a new domian class which inherits from {{gtClass:LcsDomainCollection}} or one of its subclasses. (ex: LxxPerson). Instances of this class (and its subclasses) are 'domain' level objects. The only thing that they are part of is the system. So the collection that roots these instances must be part of the system class or one of its modules.
**2)** Create a new 'Unknown' class. (Ex: LxxUnknownPerson and it is a subclass of LxxPerson)  <-- this is exploritory
**3)** Create a new domain collection class (ex: LxxPersons) that will root the instances of the classes created in the previous steps. This class inherits from {{gtClass:name=LcsDomainCollection}}
**4)** In the new domain class (ex: LxxPerson) create a #parentSlotDefinition is created which allows the instance to point to its parent. For more details on this see {{gtClass:name=LcsGlobalCollectionReferenceSlot}} and  the builder used to generate the parent method {{gtClass:name=LcsGlobalCollectionReferenceSlotBuilder}}.
**5)** Create the slot definition and slot to hold the instance of the domain collection (Ex: LxxPersons). The slot must be defined in a subclass of {{gtClass:name=LcsBaseModule}}
**6)** 

2) If this is a global collection, then the slot for the new collection must be defined in a module class.
     Currently the rule for global collections is that they must live in a module. Modules inherit from  {{gtClass:LcsBaseModule}} .

 **Instance Variables**
 ------------------------
 *globalCollectionModuleClass*
 The module class which the global collection (Ex: LxxPersons) is instantiated.
 
 *unknownClassName* 
 The name of the class which is a paceholder for the domain instance where the domain instance is not yet known. Example: An Author has a person. But the author is created and the person is not yet known. The Author will be created pointing to the Unknown instance. This class is created in step 2.
 
 *protoInstances*
This is an exploritory feature for storing some data from which to create data in the system.
For example, if creating person titles, the protoinstances could contain {{Mr} {Mrs} {Dr}} etc. This would result in the 
"
Class {
	#name : #LcsDomainClassAndGlobalCollectionClassBuilderJob,
	#superclass : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#instVars : [
		'protoInstances',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'gt views' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		aStream nextPutAll: '---- Step: ' , each stepNumber , ' ----'; cr; cr.
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #command }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> addSubclassBuilders [
	self subclassNames do: [ :eachName |
		self addJobStep: (
			LcsDomainClassBuilder new
				newClassName: self classPrefix , eachName;
				targetSuperclassName: self newDomainClassName;
				targetPackageName: self targetPackageName)]
]

{ #category : #command }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self unknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self loaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self collectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses.
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> collectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self collectionSlotName;
		collectionSlotModuleName: self collectionModuleClass defaultModuleName;
		collectionClassName: self collectionClassName; 
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> collectionSlotBuilder [
	| builder |
	builder := LcsGlobalCollectionSlotBuilder new
					slotName: self collectionSlotName;
					targetClassName: self collectionModuleClass name;
					targetModuleClass: self collectionModuleClass;
					collectionMemberTypes: (OrderedCollection with:  self newDomainClassName);
					addSlotType: self collectionClassName;
					yourself.
	self buildUnknownClass ifTrue: [
		builder addJobStep: (
			LcsAccessorSlotBuilder new
				slotClassName: LcsAccessorSlot name;
				slotName: 'unknown';
				targetClassName: self collectionClassName;
				addSlotType: self unknownClassName;
				yourself)].
	^ builder
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self unknownClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newTargetClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self collectionSlotName;
		targetModuleClass: self collectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self collectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #configuration }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> generateRelatedNames [
	super generateRelatedNames.
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self unknownClassName: nil.
			^self ].
	self unknownClassName: self classPrefix , 'Unknown' , self classRootName
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalCollectionSlotBuilder) first
]

{ #category : #'gt views' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton
]

{ #category : #initialize }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> loaderBuilder [
	^ LcsLoaderClassBuilder new
		newClassName: self collectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #printing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: (self newDomainClassName) printString ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: (self collectionClassName) printString
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #'gt views' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> refactoringText [
	| stream |
	stream := WriteStream on: String new.
	self addRefactoringTextDetailsTo: stream.
	^ stream contents
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) ifEmpty: [ nil ] ifNotEmpty: [ :coll | coll first ]
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassName: anObject [
	unknownClassName := anObject
]

{ #category : #verification }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
