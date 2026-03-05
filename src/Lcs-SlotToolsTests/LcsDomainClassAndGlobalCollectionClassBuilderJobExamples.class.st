Class {
	#name : 'LcsDomainClassAndGlobalCollectionClassBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> installAndRemoveInvoiceAndInvoicesBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self invoiceAndInvoicesBuilderJob.
	[ builderJob execute.
	  builderJob verifyCodeInstallation ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ].
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> installAndRemoveSampleDomainObjectAndGlobalCollectionBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self sampleDomainObjectAndGlobalCollectionBuilderJob.
	[ builderJob execute.
	  builderJob verifyCodeInstallation ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ].
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> installAndRemoveSampleDomainObjectAndUnknownAndGlobalCollectionBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self sampleDomainObjectAndUnknownAndGlobalCollectionBuilderJob.
	[ builderJob execute.
	  builderJob verifyCodeInstallation ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ].
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> invoiceAndInvoicesBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self newBuilderJob
						classPrefix: 'Lxx';
						createForRootName: 'Invoice';
						installNewClassesInPackageNamed: 'Lcs-Temp';
						installCollectionSlotInClass: LxxPrototypeSystem;
						yourself.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := LcsDomainClassAndGlobalCollectionClassBuilderJob new.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> sampleDomainObjectAndGlobalCollectionBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'Sample';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					installCollectionSlotInClass: LxxPrototypeSystem;
					buildUnknownClass: false;
					yourself.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> sampleDomainObjectAndGlobalCollectionBuilderJobUmlModel [
	<gtExample>
	| umlModel bulderJob |
	bulderJob := self sampleDomainObjectAndGlobalCollectionBuilderJob.
	umlModel := bulderJob umlModel.
	self assert: umlModel collection notEmpty.
	self assert: umlModel collection size = 9.
	self assert: (umlModel allClassModelsFor: 'LxxSample') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsDomainObject') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsDomainCollection') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxSamples') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxPrototypeSystem') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsObjectsLoader') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxSamplesLoader') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsGlobalCollectionSlot') size = 1.
	^ umlModel
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> sampleDomainObjectAndUnknownAndGlobalCollectionBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'Sample';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					installCollectionSlotInClass: LxxPrototypeSystem;
					buildUnknownClass: true;
					yourself.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndGlobalCollectionClassBuilderJobExamples >> sampleDomainObjectAndUnknownAndGlobalCollectionBuilderJobUmlModel [
	| umlModel bulderJob |
	<gtExample>
	bulderJob := self sampleDomainObjectAndUnknownAndGlobalCollectionBuilderJob.
	umlModel := bulderJob umlModel.
	self assert: umlModel collection notEmpty.
	self assert: umlModel collection size = 11.
	self assert: (umlModel allClassModelsFor: 'LxxSample') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxUnknownSample') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsDomainObject') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsDomainCollection') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxSamples') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxPrototypeSystem') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsObjectsLoader') size = 1.
	self assert: (umlModel allClassModelsFor: 'LxxSamplesLoader') size = 1.
	self assert: (umlModel allClassModelsFor: 'LcsGlobalCollectionSlot') size = 1.
	^ umlModel
]
