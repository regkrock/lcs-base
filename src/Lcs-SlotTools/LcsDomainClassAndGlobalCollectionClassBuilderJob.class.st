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
		'unknownClassName',
		'buildUnknownClass',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

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
		self addJobStep: self domainUnknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self globalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses.
	self addJobStep: self loaderBuilder
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> buildUnknownClass [
	^ buildUnknownClass
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> buildUnknownClass: aBoolean [ 
	buildUnknownClass := aBoolean
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self newDomainClassName;
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
		collectionSlotName: self globalCollectionSlotName;
		targetModuleClass: self globalCollectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> domainUnknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		collectionClassName: self globalCollectionClassName; 
		addSlotType: self globalCollectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> globalCollectionSlotBuilder [
	| builder |
	builder := LcsGlobalSlotDefinitionBuilder new
					slotClassName: self globalCollectionClassName;
					slotName: self globalCollectionSlotName;
					targetClassName: self globalCollectionModuleClass name;
					targetModuleClass: self globalCollectionModuleClass;
					collectionElementTypes: { self newDomainClassName};
					addSlotType: self globalCollectionClassName;
					yourself.
	self buildUnknownClass ifTrue: [
		builder addJobStep: (
			LcsSlotDefinitionBuilder new
				slotDefinitionClassName: LcsSlotDefinition name;
				slotName: 'unknown';
				targetClassName: self globalCollectionClassName;
				addSlotType: self unknownClassName;
				yourself)].
	^ builder
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #'as yet unclassified' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> loaderBuilder [
	^ LcsLoaderClassBuilder new
		newClassName: self globalCollectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #command }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> populateSlotModel [
	super populateSlotModel.
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self unknownClass ifNotNil: [ :unknownClass | unknownClass new ].
	"self protoInstances do: [ :each | 
		self domainClassBuilderStep installedClass new
			isoCode: (each at: 1);
			countryName: (each at: 2)]."
	self currentSystem currentUnitOfWork applyChanges.
]

{ #category : #printing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self newDomainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self globalCollectionClassName
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> undefinedClassName: anObject [
	unknownClassName := anObject
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep ifNotNil: [ :step | step installedClass ]
]

{ #category : #'builder step' }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) ifEmpty: [ nil ] ifNotEmpty: [ :coll | coll first ]
]

{ #category : #accessing }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #verification }
LcsDomainClassAndGlobalCollectionClassBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
