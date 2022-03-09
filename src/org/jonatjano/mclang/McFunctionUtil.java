package org.jonatjano.mclang;

import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiManager;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import com.intellij.psi.util.PsiTreeUtil;
import org.jonatjano.mclang.psi.McFunctionFile;
import org.jonatjano.mclang.psi.McFunctionResourceLocation;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class McFunctionUtil {

    /**
     * Searches the entire project for Simple language files with instances of the Simple property with the given key.
     *
     * @param project current project
     * @param key     to check
     * @return matching properties
     */
    public static List<McFunctionResourceLocation> findResourceLocation(Project project, String namespace) {
        List<McFunctionResourceLocation> result = new ArrayList<>();
        Collection<VirtualFile> virtualFiles = FileTypeIndex.getFiles(McFunctionFileType.INSTANCE, GlobalSearchScope.allScope(project));
        for (VirtualFile virtualFile : virtualFiles) {
            McFunctionFile simpleFile = (McFunctionFile) PsiManager.getInstance(project).findFile(virtualFile);
            if (simpleFile != null) {
                McFunctionResourceLocation[] locations = PsiTreeUtil.getChildrenOfType(simpleFile, McFunctionResourceLocation.class);
                if (locations != null) {
                    for (McFunctionResourceLocation property : locations) {
                        if (namespace.equals(property.getNamespace())) {
                            result.add(property);
                        }
                    }
                }
            }
        }
        return result;
    }

    public static List<McFunctionResourceLocation> findProperties(Project project) {
        List<McFunctionResourceLocation> result = new ArrayList<>();
        Collection<VirtualFile> virtualFiles =
                FileTypeIndex.getFiles(McFunctionFileType.INSTANCE, GlobalSearchScope.allScope(project));
        for (VirtualFile virtualFile : virtualFiles) {
            McFunctionFile simpleFile = (McFunctionFile) PsiManager.getInstance(project).findFile(virtualFile);
            if (simpleFile != null) {
                McFunctionResourceLocation[] locations = PsiTreeUtil.getChildrenOfType(simpleFile, McFunctionResourceLocation.class);
                if (locations != null) {
                    Collections.addAll(result, locations);
                }
            }
        }
        return result;
    }

    /**
     * Attempts to collect any comment elements above the Simple key/value pair.
     */
//    public static @NotNull String findDocumentationComment(SimpleProperty property) {
//        List<String> result = new LinkedList<>();
//        PsiElement element = property.getPrevSibling();
//        while (element instanceof PsiComment || element instanceof PsiWhiteSpace) {
//            if (element instanceof PsiComment) {
//                String commentText = element.getText().replaceFirst("[!# ]+", "");
//                result.add(commentText);
//            }
//            element = element.getPrevSibling();
//        }
//        return StringUtil.join(Lists.reverse(result),"\n ");
//    }

}