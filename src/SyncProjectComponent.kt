import com.intellij.openapi.components.ProjectComponent
import com.intellij.openapi.project.Project
import gradle.sync

class SyncProjectComponent(val project: Project) : ProjectComponent {

    override fun projectOpened() = project.sync { error ->
        if (error != null) {
            System.err.println("Sync failed with error: $error")
            System.exit(EXIT_CODE_SYNC_FAILED)
        } else {
            System.exit(EXIT_CODE_OK)
        }
    }

    override fun initComponent() {
    }

    override fun projectClosed() {
    }

    override fun disposeComponent() {
    }

    override fun getComponentName(): String {
        return "SyncProjectComponent"
    }

}

private const val EXIT_CODE_OK = 0
private const val EXIT_CODE_SYNC_FAILED = 100